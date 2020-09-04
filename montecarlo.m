clear all
load demo_3_D
for iter = 1:100
    lambda = 3.3;
    M = 8;
    d = 3;
    param = generator(lambda,M,d);
    %param.a = param.a + 2*randn(1,M);
    H = [];
    Y = [];
    z_Upper = 9999;
    z_Lower = -9999;
    range_n = range(param);
    param.n = [0,0,0];
    param.x = [0,0];
    clear n
    clear x
    str = "";
    for i = 1:M-1
        str = str + "%2.0f,";
    end
    i = i + 1;
    str = str + "%2.0f";
    k = 1;
    i = 1;
    while(abs(z_Upper - z_Lower) > 1e-7)
        cvx_solver mosek
        [z,X,G,n] = OA_master(param,H,Y);
        z_Lower = sum(z);
        cvx_solver SDPT3
        param.n = n';
        [G_p,X_p,S_p] = NLP_P(param);
        [H_d,Y_d,S_d] = NLP_D(param);
        if S_p < z_Upper
            k = 1;
            z_Upper = S_p;
            n_best = n;
        end
        H(:,:,i) = H_d;
        Y(:,:,i) = Y_d;
        i = i + 1;
        k = k + 1;
        if k > 20 & z_Upper<2 | i > 50
            break
        end
    end
    fprintf("LB:("+str+")|UP:("+str+")\n",range_n(:,1),range_n(:,2))
    fprintf("n_e:("+str+")|n:("+str+")|Gap:%2.2f\n",param.n_e,n_best',abs(z_Upper - z_Lower))
    LB(iter,:) = range_n(:,1);
    UB(iter,:) = range_n(:,2);
    error(iter,:) = abs(param.n_e - n_best');
end
area(mean(UB)-mean(LB),'facecolor',[0.3,1,1])
hold on
title('Range of n_i')
xlabel('Sensors')
ylabel('Value of n_i')
area(mean(error),'facecolor','r')
ylim([0,1.5*(mean(mean(UB)-mean(LB)))])
legend('Range of n_i','Error')
xticks([1:M])