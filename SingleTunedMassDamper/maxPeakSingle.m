% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Maximum Peak

function X = maxPeakSingle(k2,c2,a,b)
    [maxW1,maxX1]=goldenSectionSearch(k2,c2,a,b);
    [maxW2,maxX2]=goldenSectionSearch(k2,c2,maxW1,b);
    X=max([maxX1,maxX2]);
end

function [frequency,peak] = goldenSectionSearch(k2,c2,a,b)
    tolerance=0.001;
    maxIter=1000;
    R=(sqrt(5)-1)/2;
    frequency=a; peak=response2D(k2,c2,a); peak=peak(1);
    for k=1:maxIter
        d=R*(b-a);
        w1=a+d; x1=response2D(k2,c2,w1); x1=x1(1);
        w2=b-d; x2=response2D(k2,c2,w2); x2=x2(1);
        if x1>x2
            a=w2;
        else
            b=w1;
        end
        if abs(w1-w2)<tolerance
            frequency=w2;
            peak=response2D(k2,c2,w2); peak=peak(1);
            break
        end
    end
end