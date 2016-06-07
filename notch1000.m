function Hd = notch1000
%NOTCH1000 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.5 and the DSP System Toolbox 9.0.
% Generated on: 02-Jun-2016 13:24:28

N  = 6;     % Order
F0 = 1000;  % Center frequency
Q  = 5;     % Q-factor
Fs = 4096;  % Sampling Frequency

h = fdesign.notch('N,F0,Q', N, F0, Q, Fs);

Hd = design(h, 'butter', ...
    'SOSScaleNorm', 'Linf');



