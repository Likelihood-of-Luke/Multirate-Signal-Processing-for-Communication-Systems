# Chapter 6 exercises
function [] = ch6(makePlots)
  close all;
  plotNum = 1;
  
#6.1 
  sbAttenLin = db2mag(-60);
  sbRippleLin = db2mag(0.1) - 1;
  [n, f0, a, w] = firpmord([0.04 0.06], [1 0], [sbRippleLin sbAttenLin], 2);
  lpf = firpm(n, f0, a, w);
  lpfGD = ceil(n/2);

  if (makePlots)
    figure(plotNum);
    freqz(lpf);
    title("6.1 Frequency response of Lowpass Filter. Fs = 100kHz");
    plotNum+=1;
  endif
  
  t = (1:2000);
  inputSeq = sin(pi * 32/100 * t + pi/4.2345); # 32kHz sinusoid plus some random phase
  if(makePlots)
    figure(plotNum);
    plot(inputSeq(1:100));
    title("6.1 Input sinusoid 32kHz. Fs=100kHz");
    plotNum+=1;
  endif
  
  basebandFiltered = conv(inputSeq, lpf);
  if(makePlots)
    figure(plotNum);
    plot(basebandFiltered(lpfGD:lpfGD + 1000));
    title("6.1 Suppressed baseband filtered sinusoid");
    plotNum+=1;
  endif
  
  lpfLenSeq = 1:length(lpf);
  heterodyne30k = sin(pi * 30/100 * lpfLenSeq);
  upconvertedLpf = heterodyne30k .* lpf;
##  disp(upconvertedLpf);
  if(makePlots)
    figure(plotNum);
    freqz(upconvertedLpf);
    title("6.1 Upconverted filter response");
    plotNum+=1;
  endif
  
  passbandFiltered = conv(inputSeq, upconvertedLpf);
  if(makePlots)
    figure(plotNum);
    plot(passbandFiltered(lpfGD:lpfGD + 1000));
    title("6.1 Passband heterodyned filtered sequence");
    plotNum+=1;
  endif
  

end