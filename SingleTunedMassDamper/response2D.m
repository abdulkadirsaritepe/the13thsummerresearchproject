% The 13th Summer Research Project
% Abdulkadir Sarıtepe
% Response of the single tuned mass damper systems

function X = response2D(k2,c2,W)
    m1=1;           % kg
    m2=0.1;         % kg % 0.1*(k2~=0 || c2~=0)
    F1=1;           % N
    F=[F1; 0];      % N
    M=[m1 0; 0 m2]; % kg
    k1=1;           % N/m
    c1=0.01;        % Ns/m
    
    X=[];
    for w=W
        C=[c1+c2 -c2; -c2 c2];  % N*s/m
        K=[k1+k2 -k2; -k2 k2];      % N/m
        A=(-M*w^2+C*w*1i+K);
        X=[X;abs((A^-1)*F)'];
    end
end