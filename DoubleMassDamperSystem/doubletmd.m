% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Parallel Double Tuned Mass Damper System Configuration

clc, clear, close all

isSTMD=true; isPDTMD=true; isSDTMD=true;

w_start=0.5;
w_end=1.5;
n=500;
W=linspace(w_start,w_end,n);
legendStr=[];

if isPDTMD
    parallel=true;
    V0=[0.055;0.09;0.01;0.03;0.01];
    A=diag([1;1;1;1;1]); b=[0.1;0.1;0.1;0.1;0.1];
    lb=0.0001*ones(size(V0));
    ub=0.1*ones(size(V0));

    pdtmd=@(V) (maxPeak(parallel,V(1),V(2),V(3),V(4),V(5)));

    resultPDTMD=fmincon(pdtmd,V0,A,b,[],[],lb,ub,[]); 

    m2=resultPDTMD(1); m3=0.1-resultPDTMD(1); 
    k2=resultPDTMD(2); c2=resultPDTMD(3);
    k3=resultPDTMD(4); c3=resultPDTMD(5);

    XPD=response(parallel,m2,m3,k2,c2,k3,c3,W);
    IPD=tmdIntegral(W,XPD(:,1),w_start,w_end);
    hold on
    plot(W,XPD(:,1),"LineWidth",2)
    legendStr=[legendStr;"PDTMD"];
end

if isSDTMD
    parallel=false;
    V0=[0.055;0.05;0.1;0.03;0.1];
    A=diag([1;1;1;1;1]); b=[0.1;0.1;0.1;0.1;0.1];
    lb=0.0001*ones(size(V0));
    ub=0.1*ones(size(V0));

    sdtmd=@(V) (maxPeak(parallel,V(1),V(2),V(3),V(4),V(5)));
    %sdtmd=@(V) (maxPeakIter(parallel,V(1),V(2),V(3),V(4),V(5)));

    resultSDTMD=fmincon(sdtmd,V0,A,b,[],[],lb,ub,[]); 

    m2=resultSDTMD(1); m3=0.1-resultSDTMD(1); 
    k2=resultSDTMD(2); c2=resultSDTMD(3);
    k3=resultSDTMD(4); c3=resultSDTMD(5);

    XSD=response(parallel,m2,m3,k2,c2,k3,c3,W);
    ISD=tmdIntegral(W,XSD(:,1),w_start,w_end);
    hold on
    plot(W,XSD(:,1),"LineWidth",2)
    legendStr=[legendStr;"SDTMD"];
end

if isSTMD
    V0=[0;0];
    stmd=@(V) (maxPeakSingle(V(1),V(2),w_start,w_end));
    resultSTMD=fminsearch(stmd,V0); 
    K=resultSTMD(1); C=resultSTMD(2); 
    XS=response2D(K,C,W);
    IS=tmdIntegral(W,XS(:,1),w_start,w_end);
    hold on
    plot(W,XS(:,1),"LineWidth",2)
    legendStr=[legendStr;"STMD"];
end

title("Minimum Peak")
legend(legendStr)
xlabel("\omega [rad/s]")
ylabel("x_1 [m]")