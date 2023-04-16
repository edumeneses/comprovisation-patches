(
// define a server, SATIE needs it
s = Server.supernova.local;

// instantiate a SatieConfiguration. Here we will use two stereo spatializer
~satieConfiguration = SatieConfiguration.new(
    s,
    [],
    outBusIndex: [0],
    ambiOrders: [1, 2, 3],  // list ambisonic order handled by this satie instance
    minOutputBusChannels: 4
);

// choose which ambisonic encoder you wish to use (\wave for plane or spherical wave encoding, \harmonic for better CPU performance)
~satieConfiguration.hoaEncoderType = \wave;

// list possible listeners:
~satieConfiguration.spatializers.keys;
~satieConfiguration.server.options.numOutputBusChannels = 64;
~satieConfiguration.server.options.numInputBusChannels = 8;
~satieConfiguration.server.options.memSize = 2.pow(18).asInteger;
~satieConfiguration.server.options.numWireBufs = 64 * 16;

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

    // instantiate two ambisonic decoders for order 1
    ~satie.replaceAmbiPostProcessor([\HOABinaural], spatializerNumber: 0, order: 1, outputIndex: ~satieConfiguration.outBusIndex);
    ~sound = ~satie.makeSourceInstance(\demoSynth, \testtoneAmbi1, \default, synthArgs: [\density, 15, \attack, 25, \gainDB, -10]);

    // Create a synth to generate movement
    SynthDef(\circular, { | out, trig, speed=1, direction=1 |
    var sig;
    sig = Phasor.kr(trig, speed/2, -180*direction, 180*direction, 0);
    //SendReply.kr(Impulse.kr(100), '/pos', sig);
        Out.kr(out, sig);
    }).add;

    // Create a bus to map the movement
    ~circularBus = Bus.control(s);

    // start the synth
    s.sync;
    ~circularSynth = Synth(\circular, [\out, ~circularBus, \rpm, 1]);

    // map the bus
    ~sound.set(\aziDeg, ~circularBus.asMap);

    //o = OSCFunc({ |msg| if(msg[3]!=180,{msg[3].postln}); }, '/pos');

    ~lcd.sendMsg('/lcd', "MPU - Metalab(SAT)  ", 1, 1);
	~lcd.sendMsg('/lcd', "SATIE - HOABinaural ", 2, 1);
	~lcd.sendMsg('/lcd', "                    ", 3, 1);

});
)
