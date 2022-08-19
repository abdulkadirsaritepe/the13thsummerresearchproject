% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Tuned Mass Damper System with Non-linear Spring

clc, clear, close all

kc=3; c2=0.001; w=0.5;

X=response2D(kc,c2,1);

t_start=0;
t_end=800; %2500
n=10000; n2=500;

T1=linspace(t_start,t_end,n);

y0=[0;0;0;0];

[~, ynl] = ode45(@(t,y) nonlineartmd(t,y,kc,c2,w), T1, y0);

figure('Renderer', 'painters', 'Position', [100 100 1000 500])
subplot(1,2,1)
plot(T1,ynl(:,1),"b","LineWidth",1)
ylabel("x_1 (m)")
xlabel("t (s)")
subplot(1,2,2)
plot(T1(end-n2:end),ynl(end-n2:end,1),"LineWidth",1)
ylabel("x_1 (m)")
xlabel("t (s)")
hold off

function result=nonlineartmd(t,y,kc,c2,w)
    m1=1; m2=0.1; k1=1; c1=0.01; 
    F1=sin(w*t); 
    result=zeros(4,1);
    result(1)=y(2); % x1
    result(2)=(F1-(c1+c2)*y(2)+c2*y(4)-k1*y(1)-kc*(y(1)-y(3))^3)/m1;
    result(3)=y(4); % x2
    result(4)=(c2*y(2)-c2*y(4)-kc*(y(3)-y(1))^3)/m2;
end
