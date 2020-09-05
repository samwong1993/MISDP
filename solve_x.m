function param = solve_x(param)
    obj = objective(param);
    rho = param.rho;
    [M,d] = size(param.s);
    x_0 = param.x_0 + 10*randn(1,d);
    for i = 1:100000
        x = param.x;
        obj_old = obj;
        g_x = grad_x(param);
        x = x - 0.01*g_x;
        if norm(x - x_0) > rho
            x = (x - x_0)/norm(x - x_0)*rho + x_0;
        end
        param.x = x;
        obj = objective(param);
        if abs(obj-obj_old)<1e-7
            break
        end
    end
end