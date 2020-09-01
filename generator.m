function param = generator(lambda,M,d)
    for i = 1:M
        s(i,:) = 100*rand(1,2);
    end
    n = round(rand(1,M)*20);
    x = 200*rand(1,2);
    x_0 = x + 20*rand(1,2);
    alpha = norm(x - x_0);
    for i = 1:M
        a(i) = norm(x-s(i,:)) - n(i)*lambda;
    end
    param.lambda = lambda;
    param.x_e = x;
    param.n_e = n;
    param.x = x;
    param.s = s;
    param.a = a;
    param.n = n;
    param.x_0 = x_0;
    rho = 1.5*norm(x - x_0);
    param.rho = rho;
    obj = objective(param);
end