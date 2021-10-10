function y = gen_wave(tone,rythm)
rythm=rythm*1;
Fs = 8192;
freqs = [523,587,659,698,783,880,988,1046,1174,1318,1396,1567,1760,1975,261,293,329,349,391,440,493];
x = linspace(0,2 * pi * rythm,floor(Fs * rythm)); y = sin(freqs(tone) * x) .* (1 - x/(rythm * 2 * pi)); 
end