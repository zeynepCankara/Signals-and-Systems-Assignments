%% ASSIGNMENT 1
% Author: Zeynep CANKARA
% Course: EEE391 Signals and Systems

%% Helpers
% degree to radian
degree_to_radian = @(deg) (deg * pi / 180);
% radian to degree
radian_to_degree = @(rad) (rad * 180 / pi);
% to cartesian
to_cartesian = @(len, deg) len .* exp(1i * degree_to_radian(deg));
% to polar
to_polar = @(num) [abs(num) radian_to_degree(angle(num))];


%% Part (i)

% read user input
omega_0 = input('Enter the omegao value: ');
A1 = input('Enter the A1 value: ');
A2 = input('Enter the A2 value: ');
A3 = input('Enter the A3 value: ');
phi_1 = input('Enter the phi1 value (deg): ');
phi_2 = input('Enter the phi2 value (deg): ');
phi_3 = input('Enter the phi3 value (deg): ');

%% Part (ii)

% (a) represent signals as phasors
X_1p = A1 * exp(1i*degree_to_radian(phi_1));
X_2p = A2 * exp(1i*degree_to_radian(phi_2));
X_3p = A3 * exp(1i*degree_to_radian(phi_3));

% (b) convert back to the rectangular form
X_1r = to_cartesian(A1, phi_1);
X_2r = to_cartesian(A2, phi_2);
X_3r = to_cartesian(A3, phi_3);

% (c) add the real and imaginary parts
X = X_1r + X_2r + X_3r;

% (d) convert back to the polar
X_polar = to_polar(X);

X_res = X_polar(1,1) * exp(1i*degree_to_radian(X_polar(1,2)));


% Report A and phi values
fprintf('A: %.4f, phi: %.4f \n', X_polar(1,1), X_polar(1,2));

%% Part (iii)

% resulting sinusoidal
fprintf('Resulting sinusoidal: ');
print_signal(X_polar(1,1), omega_0, degree_to_radian(X_polar(1,2)));

%% Part (iv)

% define vectors
res_phasor = (X_res);
phasors = [X_1p; X_2p; X_3p];

% Plot
figure;
plot(real(phasors), imag(phasors), '->','LineWidth',1)
hold on
plot(real(res_phasor), imag(res_phasor), '->','LineWidth',3.5)
hold off
xlim([-30 30]);
ylim([-30 30]);
title('Part (iv): phasor addition plot');
xlabel('Real part');
ylabel('Imaginary part');
grid on;

%% Part (v)

% define vectors
phasors = cumsum([X_1p; X_2p; X_3p]);
res_phasor = [0; res_phasor];
phasors = [0; phasors]; % concat with origin as starting point

% Plot
figure;
plot(real(phasors), imag(phasors), '->','LineWidth',1)
hold on
plot(real(res_phasor), imag(res_phasor), '->','LineWidth',3.5)
hold off
xlim([-30 30]);
ylim([-30 30]);
title('Part(v): phasor addition end to end plot');
xlabel('Real part');
ylabel('Imaginary part');
grid on;


%% Function declerations
function print_signal(A, omega_0, phi)
    if phi < 0
        fprintf('x(t) = %.2f cos(%.2ft - %.2f)\n', A, omega_0, abs(phi));
    else
        fprintf('x(t) = %.2f cos(%.2ft + %.2f)\n', A, omega_0, phi);
    end
end