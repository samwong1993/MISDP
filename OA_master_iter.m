function [z,X,G,n] = OA_master_iter(param,H,Y,G)
    a = param.a;
    s = param.s;
    range_n = range(param);
    lambda = param.lambda;
    [M,d] = size(s);
    for i = 1:M
        A(:,:,i) = [eye(d),-s(i,:)';-s(i,:),s(i,:)*s(i,:)'];
    end
    cvx_optval = 0;
    index = 1:M;
    error = 9999;
    z = 0;
    while(1)
        if error<1e2
            break
        end
        error = 0;
        for i = 1:M
            fprintf("Gap:%2.2f|",full(abs(G(i,i) - G(i,M+1)^2)))
            if full(abs(G(i,i) - G(i,M+1)^2))<1
                del_i = find(index == i);
                index(del_i) = [];
            else
                del_i = find(index == i);
                index = [index,del_i];
                index = unique(index);
            end
            error = error + full(abs(G(i,i) - G(i,M+1)^2));
        end
        fprintf("Obj:%2.2f\n",sum(z))
        if isinf(cvx_optval)
            for i = 1:length(index)
                G_mid(index(i),index(i)) = (G_mid(i,i) + G_old(i,i))/2;
            end   
        else
            for i = 1:length(index)
                G_mid(i,i) = (G(i,i) + G(i,M+1)^2)/2;
            end   
            G_old = G;
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
                - z(i) <= a(i) + n(i)*lambda - G(i,M+1) <= z(i)
                G(i,i) <= G_mid(i,i)
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
end
