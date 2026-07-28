function dydt = B_H_model(~, y, params)
    N = y(1); B = y(2); H = y(3); M = y(4); A = y(5); D = y(6);

    % Monod terms
    monod_B = N / (params.K_BN + N);
    monod_H_N = N / (params.K_HN + N);
    monod_H_M = M / (params.K_HM + M);
    monod_B_D = D / (params.K_BD + D);

    % Growth rates
    growth_B_N = params.mu_B * monod_B * B;
    growth_H = params.mu_H * monod_H_N * monod_H_M * H;
    growth_B_D = params.mu_B * monod_B_D * B;

    % Hill activation function
    hill_activate = (N^params.h) / (params.Ncrit^params.h + N^params.h);

    % Differential equations
    dNdt = - (1/params.Y_B)*growth_B_N - (1/params.Y_HN)*growth_H - params.delta_N*N;
    dBdt = growth_B_N + growth_B_D;
    dHdt = growth_H - params.kappa * A * H;
    dMdt = params.alpha * hill_activate * B - (1/params.Y_HM) * growth_H;
    dAdt = params.gamma * (1-hill_activate) * B  - params.delta_A * A;
    dDdt = params.epsilon * params.kappa * A * H - (1/params.Y_BD)*growth_B_D;

    dydt = [dNdt; dBdt; dHdt; dMdt; dAdt; dDdt];
end
