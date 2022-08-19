% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Response of the double tuned mass damper systems
% with series and parallel configuration

function X = response(parallel,m2,m3,k2,c2,k3,c3,W)
    if m2<0 || m3<0 || k2<0 || c2<0 || k3<0 || c3<0
        X=nan; return
    end
    m1=1;           % kg
    F1=1;           % N
    F=[F1; 0; 0];      % N
    
    k1=1;           % N/m
    c1=0.01;        % Ns/m
    
    sz=size(W);
    X=ones(sz(2),3);
    M=[m1 0 0; 0 m2 0; 0 0 m3];                % kg
    if parallel
        C=[c1+c2+c3 -c2 -c3; -c2 c2 0; -c3 0 c3];  % N*s/m
        K=[k1+k2+k3 -k2 -k3; -k2 k2 0; -k3 0 k3];  % N/m
    else
        C=[c1+c2 -c2 0; -c2 (c2+c3) -c3; 0 -c3 c3];  % N*s/m
        K=[k1+k2 -k2 0; -k2 (k2+k3) -k3; 0 -k3 k3];  % N/m
    end
    q=1;
    for w=W
        A=(-M*w^2+C*w*1i+K);
        X(q,:)=abs(A\F)';
        q=q+1;
    end
end