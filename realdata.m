function param = realdata()
    s(1,:) = [0,0,5];  
    s(2,:) = [879,0,15];  
    s(3,:) = [0,1115,20];  
    s(4,:) = [1023,887,4]; 
    s(5,:) = [-990,-1220,10]; 
    x_e = [700,800,750];
    lambda = 30;
    n = [7,-6,10,-8,12];
    for i = 1:5
        a(i) = norm(s(i,:)-x_e) - lambda*n(i);
    end
    x_0 = [742.9056830686393,  828.9119358686863,    754.2132237405466]; 
    %%   x_0  =  x_e + (1 - rand(3,1))*50;  
    rho = 60;
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