function [H,Y,S] = NLP_D(param)
    a = param.a;
    s = param.s;
    lambda = param.lambda;
    [M,d] = size(s);
    n = param.n;
    E_0 = zeros(M+1,M+1);
    E_M1M1 = E_0;
    E_M1M1(M+1,M+1) = 1;
    E_d1d1 = zeros(d+1,d+1);
    E_d1d1(d+1,d+1) = 1;
    for i = 1:M
        r(i) = a(i) + n(i)*lambda;
    end
    for i = 1:M
        A(:,:,i) = [eye(d),-s(i,:)';-s(i,:),s(i,:)*s(i,:)'];
    end
    E_11 = E_0; 
    E_11(1,1) = 1; 
    E_22 = E_0; 
    E_22(2,2) = 1; 
    E_33 = E_0; 
    E_33(3,3) = 1; 
    E_1M1 = E_0;
    E_1M1(1,M+1) = 1;
    E_2M1 = E_0;
    E_2M1(2,M+1) = 1;
    E_3M1 = E_0;
    E_3M1(3,M+1) = 1;
    cvx_begin quiet
    cvx_precision high
        variable lambda_G_X(M)
        variable lambda_G 
        variable lambda_X
        variable H(M+1,M+1) symmetric
        variable Y(d+1,d+1) symmetric
        maximize -lambda_G-lambda_X+sum(r.^2)
        H == (1 + lambda_G_X(1))*E_11 - r(1)*(E_1M1+E_1M1') + (1 + lambda_G_X(2))*E_22 - r(2)*(E_2M1+E_2M1')+ (1 + lambda_G_X(3))*E_33 - r(3)*(E_3M1+E_3M1') + lambda_G*E_M1M1
        Y == -(lambda_G_X(1)*A(:,:,1) + lambda_G_X(2)*A(:,:,2) + lambda_G_X(3)*A(:,:,3)) + lambda_X*E_d1d1
        H == semidefinite(M+1)
        Y == semidefinite(d+1)
    cvx_end
    S = -lambda_G-lambda_X+sum(r.^2);
end
