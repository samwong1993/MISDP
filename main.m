clear all
lambda = 1;
M = 6;
d = 3;
% %load data
param = generator(lambda,M,d);
% param = realdata();
[M,d] = size(param.s);
%param.a = param.a + 2*randn(1,M);
%initialization
H = [];
Y = []; 
z_Upper = 9999;
z_Lower = -9999;
range_n = range(param);
%delete all the variables
param.n = zeros(1,M);
param.x = zeros(1,d);
clear n
clear x
%set output format
str = "";
for i = 1:M-1
    str = str + "%2.0f,";
end
i = i + 1;
str = str + "%2.0f";
k = 1;
i = 1;
%OA algorithm
while(abs(z_Upper - z_Lower) > 1e-8)
    cvx_solver mosek
    [z,X,G,n] = OA_master(param,H,Y);
%     [z,X,G,n] = OA_master_iter(param,H,Y,G);
    z_Lower = sum(z);
    cvx_solver SDPT3
    param.n = n';
    %[G_p,X_p,S_p] = NLP_P(param);
    [H_d,Y_d,S_d] = NLP_D(param);
    param = solve_x(param);
    obj = objective(param);
    if obj < z_Upper
        k = 1;
        z_Upper = obj;
        n_best = n;
    end
    H(:,:,i) = H_d;
    Y(:,:,i) = Y_d;
    i = i + 1;
    k = k + 1;
    fprintf("LB:("+str+")|UP:("+str+")|Gap:%2.2f\n",range_n(:,1),range_n(:,2),abs(z_Upper - z_Lower))
    fprintf("n_e:("+str+")|n:("+str+")|Fun:%2.2f\n",param.n_e,n_best',obj)
    if k > 20 & z_Upper < 5 | i > 50
        break
    end
end
fprintf("LB:("+str+")|UP:("+str+")|Gap:%2.2f\n",range_n(:,1),range_n(:,2),abs(z_Upper - z_Lower))
fprintf("n_e:("+str+")|n:("+str+")|Fun:%2.2f\n",param.n_e,n_best',abs(z_Upper - z_Lower))
param.n = n_best';
param = solve_x(param);
fprintf("Error Range:(%2.2f,%2.2f)m|Error:%2.2fm|Estimated Error:%2.2fm\n",(param.rho + norm(param.x_0 - param.x_e))*1000,(param.rho - norm(param.x_0 - param.x_e))*1000,norm(param.x_0 - param.x_e)*1000,norm(param.x - param.x_e)*1000)
if d == 3
%     earth
    demo_3_D(param);
end