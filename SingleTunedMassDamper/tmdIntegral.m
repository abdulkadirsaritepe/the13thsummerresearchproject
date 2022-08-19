% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% The Integral of the Response of the Tuned Mass Damper System

function I=tmdIntegral(x,y,l,u)
    indexL=find(x==l);
    indexU=find(x==u);
    indexes=indexL:indexU;
    n=length(indexes);
    h=(u-l)/(n-1);
    sum=0;
    for k=indexes(2:end-1)
        sum=sum+y(k);
    end
    I=(h/2)*(y(indexL)+y(indexU)+2*sum);
end