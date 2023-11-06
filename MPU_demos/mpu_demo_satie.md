# MPU / SATIE / Gestural controller demo

This MPU box runs the custom OS created by Metalab and IDMIL on a Rpi. 
LCD and internal audio inteface are optional components.

The MPU runs headlessly a SC code that creates an stereo spatializer and pans the audio source between the ears.
optionally, One can use the GuitarAMI module to control the sound object position.

## instructions

1. Turn the MPU ON (use the button located on the power cable)
2. Wait for the SATIE demo to completely boot (it takes around 30 seconds)
3. Put the phones and listen

Optionally, the GuitarAMI module can be used to control the sound object position:

1. disconnect the module from the power cable
2. turn it on
3. wait for the GuitarAmi module to connect to the MPU (the module led will blink in blue)
4. move the module (pitch to move the sound source):
   1. point the ultrasonic sensor to you and tilt the module left or right

**Have fun!**