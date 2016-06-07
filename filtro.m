close all,clear all;
pkg load signal;
sf2 = 4096/2;
order= 1;
%notch en 1000
%[b,a]=pei_tseng_notch ( 1000 / sf2, 100/sf2 );

n= 22;             % Filter order
f = [0 0.4 0.5 1];  % Frequency vector
a = [1 1 0 0];      % Magnitude vector
w = [1 5];   
b = remez (n, f, a, w); 
%[b, a] = ellip (3, 20, 100,[0.2, 0.6]);

figure
freqz (b);

n= 22
a = [10 10 0 0];      % Magnitude vector
w = [1 1];  
b = remez (n, f, a, w); 
figure
freqz (b);  