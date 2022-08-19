% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Maximum Peak Test

function [wn,wk,r,Ws,Xs,X] = maxPeakTest(parallel,m2,k2,c2,k3,c3)

    if k2<0 || c2<0 || k3<0 || c3<0 || m2<0% || m3<0 || m2+m3>0.1
        X=nan; return
    end
    m1=1; k1=1; m3=0.1-m2;
    M=[m1 0 0; 0 m2 0; 0 0 m3];
    if parallel
        K=[k1+k2+k3 -k2 -k3; -k2 k2 0; -k3 0 k3];
    else
        K=[k1+k2 -k2 0; -k2 (k2+k3) -k3; 0 -k3 k3];
    end
    
    k=[k1;k2;k3];
    m=[m1;m2;m3];
    wn=(sort(eig(K,M))).^0.5;
    wk=(k./m).^0.5;
    r=wk./wn;
    [maxW1,maxX1]=goldenSectionSearch(parallel,m2,m3,k2,c2,k3,c3,wn(1));
    [maxW2,maxX2]=goldenSectionSearch(parallel,m2,m3,k2,c2,k3,c3,wn(2));
    [maxW3,maxX3]=goldenSectionSearch(parallel,m2,m3,k2,c2,k3,c3,wn(3));

    Ws=[maxW1;maxW2;maxW3];
    Xs=[maxX1;maxX2;maxX3];
    X=max(Xs);
end

function [frequency,peak] = goldenSectionSearch(parallel,m2,m3,k2,c2,k3,c3,wn)
    bracket=0.05;
    tolerance=0.0001;
    maxIter=1000;
    R=(sqrt(5)-1)/2;

    a=wn*(1-bracket); b=wn*(1+bracket);

    frequency=a; peak=response(parallel,m2,m3,k2,c2,k3,c3,a); peak=peak(1);
    for k=1:maxIter
        d=R*(b-a);
        w1=a+d; x1=response(parallel,m2,m3,k2,c2,k3,c3,w1); x1=x1(1);
        w2=b-d; x2=response(parallel,m2,m3,k2,c2,k3,c3,w2); x2=x2(1);
        if x1>x2
            a=w2;
        else
            b=w1;
        end
        if abs(w1-w2)<tolerance
            frequency=w2;
            peak=response(parallel,m2,m3,k2,c2,k3,c3,w2); peak=peak(1);
            break
        end
    end
end
