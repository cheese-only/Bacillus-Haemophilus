function result = model_output(params)
a = 1.1;

% --- Initial conditions and time span ---
N0 = 500; B0 = 1; M0 = 10; H0 = 5;
tspan = [0 150];
y0_co = [N0; B0; H0; M0; 0; 0];

% --- Solve co-culture ODE ---
[t, y] = ode15s(@(t, y) B_H_model(t, y, params), tspan, y0_co);

% Extract variables
N = y(:, 1);

% Calculate cumulative self-degradation of N for co-culture
self_degrade = params.delta_N * N;
cum_self_final_co = trapz(t, self_degrade);
B_co = y(end, 2);
H_co = y(end, 3);

% --- Solve mono-culture ODE ---
params.mu_B = params.mu_B * a;
params.alpha = 0;
y0_mono = [N0; B0; H0; M0; 0; 0];

[t, y] = ode15s(@(t, y) B_H_model(t, y, params), tspan, y0_mono);

% Extract variables
N = y(:, 1);

% Calculate cumulative self-degradation of N for mono-culture
self_degrade = params.delta_N * N;
cum_self_final_mono = trapz(t, self_degrade);
B_mono = y(end, 2);

% --- Output vector ---
result = [B_co, H_co, B_mono, cum_self_final_co, cum_self_final_mono];
end