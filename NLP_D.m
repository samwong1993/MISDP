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
        A(:,:,i) = [eye(d),-s(i,:)';-s(i,:),s(i,:)*s(i,:)'];
        eval("E_"+string(i)+string(i)+"= E_0;")
        eval("E_"+string(i)+string(i)+"("+string(i)+","+string(i)+")= 1;")
        eval("E_"+string(i)+"M1"+"= E_0;") 
        eval("E_"+string(i)+"M1"+"("+string(i)+",M+1)= 1;")
        H_lhs(i) = "(1 + lambda_G_X("+string(i)+"))*E_"+string(i)+string(i)+" - r("+string(i)+")*("+"E_"+string(i)+"M1+"+"E_"+string(i)+"M1"+"')";
        Y_lhr(i) = "lambda_G_X("+string(i)+")*A(:,:,"+string(i)+")";
    end
    H_sum = "";
    Y_sum = "-";
    for i = 1:M-1
        H_sum = H_sum + H_lhs(i) + "+";
        Y_sum = Y_sum + Y_lhr(i) + "-";
    end
    i = i + 1;
	H_sum = H_sum + H_lhs(i);
    Y_sum = Y_sum + Y_lhr(i);
    cvx_begin quiet
    cvx_precision best
        variable lambda_G_X(M)
        variable lambda_G 
        variable lambda_X
        variable H(M+1,M+1) symmetric
        variable Y(d+1,d+1) symmetric
        maximize -lambda_G-lambda_X+sum(r.^2)
        H == eval(H_sum) + lambda_G*E_M1M1
        Y == eval(Y_sum) + lambda_X*E_d1d1
        H == semidefinite(M+1)
        Y == semidefinite(d+1)
    cvx_end
    S = - lambda_G - lambda_X + sum(r.^2);
end
