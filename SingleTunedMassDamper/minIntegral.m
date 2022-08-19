% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Minimum integral

clc, clear, close all

w_start=0.7;
w_end=1.2;
n=200;
k2=0.1;kdx=0.01;c2=0.1;cdx=0.01; 

[I,K,C]=tmdMinIntegral(w_start,w_end,n,k2,kdx,c2,cdx);
[I2,K2,C2]=tmdMinIntegral(w_start,1.3,n,k2,kdx,c2,cdx);

%%
minX=response(K,C,linspace(w_start,w_end,n));
minX2=response(K2,C2,linspace(w_start,w_end,n));
nonTMDX=response(0,0,linspace(w_start,w_end,n));
plot(linspace(w_start,w_end,n),log10(minX(:,1)),"LineWidth",1.2)
hold on
plot(linspace(w_start,w_end,n),log10(minX2(:,1)),"LineWidth",1.2)
hold on
plot(linspace(w_start,w_end,n),log10(nonTMDX(:,1)),"LineWidth",1.2)
title("Minimum Area and Non-TMD Configurafions")
legend(["Minimum Area where"+newline+"k_2="+num2str(K)+" and c_2="+num2str(C),"Minimum Area where"+newline+"k_2="+num2str(K2)+" and c_2="+num2str(C2),"Non-TMD"],"Location","northwest")
xlabel("\omega [rad/s]")
ylabel("x_1 [m]")

%%
% minX=response(K,C,linspace(w_start,w_end,n));
% nonTMDX=response(0,0,linspace(w_start,w_end,n));
% yyaxis left
% plot(linspace(w_start,w_end,n),minX(:,1),"LineWidth",1.2)
% ylabel("response")
% yyaxis right
% plot(linspace(w_start,w_end,n),nonTMDX(:,1),"LineWidth",1.2)
% title("Minimum area configurafion")
% legend(["Minimum Area","Non-TMD"])
% xlabel("\w")
% ylabel("response")