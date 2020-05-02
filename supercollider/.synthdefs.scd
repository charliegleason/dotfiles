(
    var offset, osc, nBufs, bufSize, pluckTable;
    nBufs = 256;
    bufSize = 4096;

    try {b.do(_.free)};

    pluckTable = Buffer.allocConsecutive(nBufs, s, bufSize, 1,
        {|buf, i| buf.sine1Msg((1..(bufSize / 2)) collect: {|j| j.reciprocal.pow((i / 4) + 1)})
    });

    SynthDef(\wtPluck, {|bufs, freq=440, len=1, det=0, curve = -4,
                         pLfoAmt=0, pLfoFreq=1, amp=1, pan=0, out=0|
        var sig, chain, bEnv, aEnv, pLfo, seed, f;
        bEnv = Line.kr(0, 128, 1);
        aEnv = amp * EnvGen.kr(Env.perc(0.005, len / curve.abs), 1, doneAction: 2);
        pLfo = SinOsc.kr(aEnv * pLfoFreq, 0, pLfoAmt);
        sig = VOsc.ar(bEnv, freq + pLfo, 0, aEnv);
        sig = Pan2.ar(sig, pan);

        Out.ar(out, sig);
    }).add;


    SynthDef(\addPluck1, {|out=0, freq=440, dB=0, dec=1, partials=4, brightness=1|
        var env, partial, pan, sig;

        if (brightness > 1) { brightness = 1 } {}

        env = {|i|
            var action = 0;
            if (i <= 1) { action = 2 } {};
            EnvGen.ar(Env.perc(0.0, dec * brightness.pow(i)), 1, doneAction: action)
        };

        partial = {|i, env|
            Pan2.ar(dB.dbamp * SinOsc.ar(freq * i) * env, -1.pow(i)) / i
        };

        pan = {|i, in|
            Pan2.ar(in, -1.pow(i))
        };

        sig = (1..128).collect({|i| pan.(i, _) <> partial.(i, _) <> env.(i)}).sum;
        Out.ar(out, sig);
    }).add;
)
