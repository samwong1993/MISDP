function [z,X,G,n] = OA_master(param,H,Y)
    a = param.a;
    s = param.s;
    range_n = range(param);
    lambda = param.lambda;
    [M,d] = size(s);
    for i = 1:M
        A(:,:,i) = [eye(d),-s(i,:)';-s(i,:),s(i,:)*s(i,:)'];
    end
    cvx_begin quiet
    cvx_precision high
        variable z(M)
        variable X(d+1,d+1) symmetric
        variable G(M+1,M+1) symmetric
        variable R(2,2,M) symmetric
        variable n(M) integer
        minimize sum(z)
        for i = 1:M
            G(i,i) == trace(X*A(:,:,i));
            -z(i) <= a(i) + n(i)*lambda - G(i,M+1) <= z(i)
        end
        G(M+1,M+1) == 1
        X(d+1,d+1) == 1
        if ~isempty(H)
            for i = 1:size(H,3)
                trace(G*H(:,:,i)) >= 0
                trace(X*Y(:,:,i)) >= 0
            end
        end
        for i = 1:M
            range_n(i,1) <= n(i) <= range_n(i,2)
            R(:,:,i) == semidefinite(2)
            R(1,1,i) == G(i,i)
            R(2,2,i) == 1
            R(1,2,i) == G(i,M+1)
        end
    cvx_end
end