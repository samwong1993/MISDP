function param = generator(lambda,M,d)
    rho = 5;
    x_0 = 500*rand(1,d);
    for i = 1:M
        s(i,:) = 200*rand(1,d);
    end
    r = 2*rho/sqrt(d);
    x = x_0 + r*rand(1,3) - r/2;
	for i = 1:M
        n(i) = floor(norm(x-s(i,:))/lambda);
    end
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
    param.rho = rho;
    param.obj = objective(param);
end