(
//	var offset, osc, nBufs, bufSize, pluckTable;
//	nBufs = 256;
//	bufSize = 4096;
//
//	try {b.do(_.free)};
//
//	pluckTable = Buffer.allocConsecutive(nBufs, s, bufSize, 1,
//		{|buf, i| buf.sine1Msg((1..(bufSize / 2)) collect: {|j| j.reciprocal.pow((i / 4) + 1)})
//	});
//
//	SynthDef(\wtPluck, {|bufs, freq=440, len=1, det=0, curve = -4,
//	pLfoAmt=0, pLfoFreq=1, amp=1, pan=0, out=0|
//		var sig, chain, bEnv, aEnv, pLfo, seed, f;
//		bEnv = Line.kr(0, 128, 1);
//		aEnv = amp * EnvGen.kr(Env.perc(0.005, len / curve.abs), 1, doneAction: 2);
//		pLfo = SinOsc.kr(aEnv * pLfoFreq, 0, pLfoAmt);
//		sig = VOsc.ar(bEnv, freq + pLfo, 0, aEnv);
//		sig = Pan2.ar(sig, pan);
//
//		Out.ar(out, sig);
//	}).add;

if (Server.program.asString.endsWith("scsynth")) {
	SynthDef(\dispersion, { |in=0, cascade=64, coeff1=0.0, coeff2 = -0.95, delay=1, fb=0, mix=1.0|
		var sig;
		sig = In.ar(in, 2);
		sig = Dispersion.ar(sig, cascade, coeff1, coeff2, delay, fb);
		ReplaceOut.ar(in, sig);
	}).add;
} {
	Pipe.call("rm " ++ Platform.userAppSupportDir +/+ "synthdefs" +/+ "*", "w");
};

SynthDef(\pulse, { |out=0, amp=1, decay=0, pan=0, lpFreq=2e4|
	var sig;
	sig = Line.ar(1, 0, decay.max(SampleRate.ir.reciprocal), amp, 0, Done.freeSelf);
	sig = Pan2.ar(LPF.ar(sig, lpFreq), pan);
	Out.ar(out, sig);
}).add;

SynthDef(\expSinGrain, { |out=0, freq=440, amp=0, mod=1, pan=0|
	var sig, env;
	// Hanning window
	env = EnvGen.ar(Env.sine(freq.reciprocal, amp.dbamp), doneAction: Done.freeSelf);
	sig = Pan2.ar(_, pan)
	<> LeakDC.ar(_)
	<> {|x| (pi * x * (mod * x).exp).sin }
	<> LFSaw.ar(freq, 1);
	Out.ar(out, sig * env);
}).add;

SynthDef(\mouse, { |out=0|
	Out.kr(out, [(MouseY.kr(-1, 1) * (2 * 16 / 9)).clip(-1, 1),
	MouseX.kr(-1, 1)])
}).add;
)
