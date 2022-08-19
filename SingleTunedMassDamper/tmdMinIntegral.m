% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% The Minimum Integral Configuration of the Response of the Tuned Mass Damper System

function [minI,K,C]=tmdMinIntegral(l,u,n,k2,kdx,c2,cdx)
    kArray=0:kdx:k2;
    cArray=0:cdx:c2;

    w=linspace(l,u,n);
    h=(u-l)/(n-1);
    minI=0;
    for k=kArray
        for c=cArray
            y=response(k,c,w);
            y=y(:,1);
            sum=0;
            for j=2:length(w)-1
                sum=sum+y(j,1);
            end
            I=(h/2)*(y(1)+y(end)+2*sum);
            if minI>I || minI==0
                minI=I; K=k; C=c;
            end
        end
    end
end