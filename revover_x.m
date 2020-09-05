function param = revover_x(param)
    obj_min = 9999;
    for i = 1:20
        param = solve_x(param);
        obj = objective(param);
        if obj < obj_min
            obj_min = obj;
            x_min = param.x;
        end
    end
    param.x = x_min;
end