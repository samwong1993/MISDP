function [G,X,S] = NLP_P(param)
    a = param.a;
    s = param.s;
    range_n = range(param);
    lambda = param.lambda;
    n = param.n;
    [M,d] = size(s);
    for i = 1:M
            A(:,:,i) = [eye(d),-s(i,:)';-s(i,:),s(i,:)*s(i,:)'];
            r(i) = a(i) + n(i)*lambda;
    end
    cvx_begin quiet
    cvx_precision best
        variable z(M)
        variable X(d+1,d+1) symmetric
        variable G(M+1,M+1) symmetric
        minimize sum(z)
        for i = 1:M
            G(i,i) == trace(X*A(:,:,i));
            z(i) == G(i,i) - 2*r(i)*G(i,M+1) + r(i)^2
        end
        G(M+1,M+1) == 1
        X(d+1,d+1) == 1
        G == semidefinite(M+1)
        X == semidefinite(d+1) 
    cvx_end
    S = sum(z);
end
