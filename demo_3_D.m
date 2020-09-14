function demo_3_D(param)
    figure(1)
    clf
    hold on
    [M,d] = size(param.s);
%     for i = 1:M
%         xyz = param.s(i,:);
%         xyz = [xyz;param.x_e];
%         comet3(xyz(:,1),xyz(:,2),xyz(:,3),0.1);
%         point2 = scatter3(param.s(i,1),param.s(i,2),param.s(i,3),'filled','c');
%     end
    point1 = scatter3(param.x_e(1),param.x_e(2),param.x_e(3),50,'filled','r');
    point3 = scatter3(param.x(1),param.x(2),param.x(3),50,'k*');
    point2 = scatter3(param.x_0(1),param.x_0(2),param.x_0(3),'filled','c');
	legend([point1,point2,point3],'Emitter', 'Sensors','Estimated Location','AutoUpdate','off');
    grid on
    rotate3d on
    [x,y,z] = sphere(30);
    x = param.x_0(1) + param.rho*x;
    y = param.x_0(2) + param.rho*y;
    z = param.x_0(3) + param.rho*z;
    surf(x,y,z)
    axis equal
    alpha(0.2)
    shading flat
end
