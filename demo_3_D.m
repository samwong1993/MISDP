function demo_3_D(param)
    figure(1)
    hold
    [M,d] = size(param.s);
    for i = 1:M
        xyz = param.s(i,:);
        xyz = [xyz;param.x_e];
        comet3(xyz(:,1),xyz(:,2),xyz(:,3),0.1);
        point2 = scatter3(param.s(i,1),param.s(i,2),param.s(i,3),'filled','c');
    end
    point1 = scatter3(param.x_e(1),param.x_e(2),param.x_e(3),50,'filled','r');
    point3 = scatter3(param.x(1),param.x(2),param.x(3),50,'k*');
	h = legend([point1,point2,point3],'Emitter', 'Sensors','Estimated Location','AutoUpdate','off');
    grid on
end
