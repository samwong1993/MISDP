function range_n = range(param)
    lambda = param.lambda;
    n = param.n;
    s = param.s;
    a = param.a;
    x_0 = param.x_0;
    rho = param.rho;
    for i = 1:length(a)
        range_n(i,1) = ceil(((norm(x_0 - s(i,:)) - rho) - a(i)) / lambda);
        range_n(i,2) = floor(((norm(x_0 - s(i,:)) + rho) - a(i)) / lambda);
    end
end