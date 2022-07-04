% BETA == 10e-11
figure('pos',[10 10 1500 1500]);
subplot(1,3,1);
stommel_plot(10e-11);

% BETA == 5e-11
subplot(1,3,2);
stommel_plot(5e-11);

% BETA == 0
subplot(1,3,3);
stommel_plot(0e-11);