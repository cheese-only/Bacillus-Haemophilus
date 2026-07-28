function dydt = B_H_C_model_killable(~, y, params)
    N = y(1); B = y(2); H = y(3); M = y(4); A = y(5); D = y(6); C = y(7);
    
    % --- Existing Monod terms ---
    monod_B = N / (params.K_BN + N);
    monod_H_N = N / (params.K_HN + N);
    monod_H_M = M / (params.K_HM + M);
    monod_B_D = D / (params.K_BD + D);
    
    % --- Additional Monod terms for C ---
    monod_C_N = N / (params.K_CN + N);
    monod_C_M = M / (params.K_CM + M);
    monod_C_D = D / (params.K_CD + D);

    % --- Growth rates ---
    growth_B_N = params.mu_B * monod_B * B;
    growth_H = params.mu_H * monod_H_N * monod_H_M * H;
    growth_B_D = params.mu_B * monod_B_D * B;
    
    growth_C_basal = params.mu_C * monod_C_N * C;
    growth_C_enhance = params.mu_C * monod_C_N * monod_C_M * C;
    total_growth_C = growth_C_basal + growth_C_enhance;
    growth_C_D = params.mu_C * monod_C_D * C;

    % Hill activation function
    hill_activate = (N^params.h) / (params.Ncrit^params.h + N^params.h);
    
    % --- Differential equations ---
    % N is consumed by B, H, and C (both pathways consume N)
    dNdt = - (1/params.Y_B)*growth_B_N - (1/params.Y_HN)*growth_H - (1/params.Y_CN)*total_growth_C - params.delta_N*N;
    
    dBdt = growth_B_N + growth_B_D;
    
    dHdt = growth_H - params.kappa * A * H;
    
    % M is consumed by H and C (only the accelerated pathway consumes M)
    dMdt = params.alpha * hill_activate * B - (1/params.Y_HM) * growth_H - (1/params.Y_CM) * growth_C_enhance;
    
    dAdt = params.gamma * (1-hill_activate) * B  - params.delta_A * A;
    
    % Sources for D include killed C
    dDdt = params.epsilon * params.kappa * A * H + params.epsilon_C * params.kappa_C * A * C - (1/params.Y_BD)*growth_B_D - (1/params.Y_CD)*growth_C_D;
    
    % Dynamics of C: growth minus killing by A
    dCdt = total_growth_C + growth_C_D - params.kappa_C * A * C;
    
    dydt = [dNdt; dBdt; dHdt; dMdt; dAdt; dDdt; dCdt];
end