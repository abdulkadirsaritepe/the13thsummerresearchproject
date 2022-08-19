% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Single Tuned Mass Damper Minimum Peak Configuration

clc, clear, close all

w_start=0.5;
w_end=1.5;
n=500;
W=linspace(w_start,w_end,n);

V0=[0;0];

f=@(V) (maxPeakSingle(V(1),V(2),w_start,w_end));

result=fminsearch(f,V0); 
K=result(1); C=result(2);

X=response2D(K,C,W);
X2=response2D(0.0918,0.0243,W);
I=tmdIntegral(W,X(:,1),w_start,w_end);

plot(W,X(:,1),"LineWidth",2)
hold on
plot(W,X2(:,1),"LineWidth",2)
title("Minimum Peak")
xlabel("\omega [rad/s]")
ylabel("x_1 [m]")