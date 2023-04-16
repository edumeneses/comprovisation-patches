(
// define a server, SATIE needs it
s = Server.supernova.local;

// instantiate a SatieConfiguration. Here we will use a stereo spatializer
~satieConfiguration = SatieConfiguration.new(s, [\stereoListener]);

// list possible listeners:
~satieConfiguration.spatializers.keys;

// Tell SATIE to not generate all SynthDefs during boot:
~satieConfiguration.generateSynthdefs = false;

// instantiate SATIE renderer and pass it the configuration
~satie = Satie.new(~satieConfiguration);

~satie.waitForBoot({

    // Setting LCD - Loopback NetAddr and Python code listening port (for the GuitarAMI MPU)
    ~lcd = NetAddr.new("127.0.0.1", 20000);

    ~lcd.sendMsg('/lcd', "MPU - Metalab(SAT)  ", 1, 1);
	~lcd.sendMsg('/lcd', "Loading SATIE demo  ", 2, 1);
	~lcd.sendMsg('/lcd', "                    ", 3, 1);

    // Instantiate Satie Introspection
    ~introspection = SatieIntrospection(~satie);

    // As we didn't generate the SynthDefs, we need to do it manually:
    ~satie.makeSynthDef(\testtone, \testtone, [],[],[], ~satieConfiguration.listeningFormat, ~satieConfiguration.outBusIndex);
    s.sync;

    // create a single synth in the default group
    ~sound = ~satie.makeSourceInstance(\demoSynth, \testtone, \default, synthArgs: [\density, 15, \attack, 25, \gainDB, -10]);

    // Create a synth to generate movement
    SynthDef(\circular, { | out, trig, speed=1, direction=1 |
    var sig;
    sig = Phasor.kr(trig, speed/2, -180*direction, 180*direction, 0);
    //SendReply.kr(Impulse.kr(100), '/pos', sig);
        Out.kr(out, sig);
    }).add;

    // Create buses to map the movement
    ~circularBus = Bus.control(s);
    ~amiWristBus = Bus.control(s);
    ~amiWristChecker = 0;

	// Create an array to filter the accelerometer values
	// AMIwrist data needs to be filtered to avoid audio artifacts
	~amiWristArray = Array.fill(50, 0);
	~amiWristArrayCounter = 0;
	~amiWristFiltered = 0;

    // start the circular synth
    s.sync;
    ~circularSynth = Synth(\circular, [\out, ~circularBus, \rpm, 1]);

    // receiving amiWrist OSC accelerometer data and saving to bus
    OSCdef.new(\accelerometer, {
        arg msg;
        var data;
		data = (msg[2]*90);
		if (~amiWristArrayCounter >= (~amiWristArray.size - 1),
			{~amiWristArrayCounter = 0},
			{~amiWristArrayCounter = ~amiWristArrayCounter + 1}
		);
		~amiWristArray[~amiWristArrayCounter] = data;
		~amiWristArray.do({arg item; ~amiWristFiltered = ~amiWristFiltered + item});
		~amiWristFiltered = ~amiWristFiltered / ~amiWristArray.size;
		~amiWristFiltered = ~amiWristFiltered.clip2(90).round(1.0);
		~amiWristFiltered.postln;
        ~amiWristBus.set(~amiWristFiltered);
		~amiWristFiltered = 0;
        }, '/AMIwrist_001/raw/accl', recvPort:8000
    );

    // map the bus
    // use the amiWrist's gestural data if available
    AppClock.sched(2.0,{
        ~amiWristBus.get({arg currentValue;
            if (currentValue != ~amiWristChecker,
                {~sound.set(\aziDeg, ~amiWristBus.asMap); ~lcd.sendMsg('/lcd', "(A)", 3, 18);},
                {~sound.set(\aziDeg, ~circularBus.asMap); ~lcd.sendMsg('/lcd', "   ", 3, 18);}
            );
        ~amiWristChecker = currentValue;
        });
		1; // delay between checkings
	});

    //o = OSCFunc({ |msg| if(msg[3]!=180,{msg[3].postln}); }, '/pos');

    ~lcd.sendMsg('/lcd', "MPU - Metalab(SAT)  ", 1, 1);
	~lcd.sendMsg('/lcd', "SATIE - demo        ", 2, 1);
	~lcd.sendMsg('/lcd', "                 ", 3, 1);

});
)

