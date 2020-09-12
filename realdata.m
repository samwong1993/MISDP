function param = realdata()
    R = 21000;
    M = 5;
    d = 3;
    x_e = [3844059.71543,709661.56843,5023129.70605]/1000;
    s(1,:) = [5394000,-1752000,2890000]/1000;  
    s(2,:) = [5979000,1943000,995700]/1000;  
    s(3,:) = [2645000,3641000,4501000]/1000;  
    s(4,:) = [947000,307700,6287000]/1000; 
    s(5,:) = [2199000,-3027000,5149000]/1000; 
    for i = 1:M
        s(i,:) = s(i,:)/norm(s(i,:))*(R + 100*randn);
    end
    lambda = 0.19/1000;
    for i = 1:M
        n(i) = floor(norm(x_e - s(i,:))/lambda);
    end
%     n = [84393725,89280850,82914200,82830407,86359910];
    for i = 1:5
        a(i) = norm(s(i,:)-x_e) - lambda*n(i);
    end
    x_0  = x_e + 2/1000*rand(1,3) - 1/1000;
    rho = 1.5*norm(x_0 - x_e);
%     x_0 = [3844063.67152181,709663.813675533,5023132.40629669];
%     rho = 6;
    param.lambda = lambda;
    param.x_e = x_e;
    param.n_e = n;
    param.x = x_e;
    param.s = s;
    param.a = a;
    param.n =  n;
    param.x_0 = x_0;
    param.rho = rho;
    param.obj = objective(param);
end