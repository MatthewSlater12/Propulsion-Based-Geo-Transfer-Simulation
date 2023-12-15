clear; clc; close all

%Establising Iterated Arrays
coe = zeros(6,1000);
X = zeros(6,1000);
coeT = zeros(6,1000);
XT = zeros(6,1000);
coeT2 = zeros(6,1000);
XT2 = zeros(6,1000);

%Degree to radian converstion
d2r = pi/180;

%Inital Orbital Conditions
inc = 83*d2r;
RAAN = 0*d2r;
argp = 0*d2r;
a = 6678.137;
e = 0;
mu = 398600.4418;
Re = 6378.137;

Tati = TRUPRO(a,mu,e);

%Convering the classical orbital eliments over time to cartisian
%coordinates array
for tt = 1:length(Tati)
    coe(:,tt) = [a,e,inc,RAAN,argp,Tati(tt)];
    X(:,tt) = COE2RV(coe(:,tt),mu);
end


%% New Trajectory Calculations 

%Burn to Transfer
TargetAP = 35786;
TargetPE = 300;
SMAT = ((TargetAP+Re)+(TargetPE+Re))/2;
EccT = 1-((TargetPE+Re)/SMAT);

TTaTi = TRUPRO(SMAT,mu,EccT);

for tt = 1:length(TTaTi)
    coeT(:,tt) = [SMAT,EccT,inc,RAAN,argp,TTaTi(tt)];
    XT(:,tt) = COE2RV(coeT(:,tt),mu);
end
% 
% %Inclination Change
IncT = 0;
% TTaTi2 = TRUPRO(SMAT,mu,IncT);
% 
% for tt = 1:length(TTaTi2)
%     coeT2(:,tt) = [SMAT,EccT,IncT,RAAN,argp,TTaTi2(tt)];
%     XT2(:,tt) = COE2RV(coeT2(:,tt),mu);
% end

%Orbit Circularisation
COTA = 35786;
SMAT2 = ((COTA+Re)+(COTA+Re))/2;
EccT2 = 1-((COTA+Re)/SMAT2);

TTaTi3 = TRUPRO(SMAT2,mu,IncT);

for tt = 1:length(TTaTi3)
    coeT3(:,tt) = [SMAT2,EccT2,IncT,RAAN,argp,TTaTi3(tt)];
    XT3(:,tt) = COE2RV(coeT3(:,tt),mu);
end

%Flight Time

T_OrbP = 2*pi*sqrt((SMAT)^3/(mu));

Transfer_Time = T_OrbP/2;
%% 3D plot code copied and modified to variables for this code from week 2 EEE3039_KeplerGraphic.M by Nicola Baresi  

[Xe,Ye,Ze] = sphere(50);

% Create figure
figure('units','normalized','outerposition',[0 0 1 1])

% Plot Earth

set(gca,'FontSize',15)
surf(Re*Xe, Re*Ye, Re*Ze, 'EdgeColor', 'none', 'FaceColor', 'c'); hold on; axis equal;
xlabel('X, ECI (km)','FontSize',20);
ylabel('Y, ECI (km)','FontSize',20);
zlabel('Z, ECI (km)','FontSize',20);


% Plot ECI axes
% quiver3(0, 0, 0, 1, 0, 0, 1e4, 'k', 'LineWidth', 2);    % I-axis
% quiver3(0, 0, 0, 0, 1, 0, 1e4, 'k', 'LineWidth', 2);    % J-axis
% quiver3(0, 0, 0, 0, 0, 1, 1e4, 'k', 'LineWidth', 2);    % K-axis
% text(1e4, 0, 0, 'I', 'FontSize', 20, 'Interpreter', 'tex', 'Color', 'k')
% text(0, 1e4, 0, 'J', 'FontSize', 20, 'Interpreter', 'tex', 'Color', 'k')
% text(0, 0, 1e4, 'K', 'FontSize', 20, 'Interpreter', 'tex', 'Color', 'k')
title('Hohmann Transfer Example Sutherland Spacehub','FontSize',20)

% Plot Trajectory
plot3(X(1,:), X(2,:), X(3,:), 'r--', 'LineWidth', 2,'DisplayName','Inital Orbit');
plot3(X(1,1), X(2,1), X(3,1), 'ok', 'MarkerFaceColor', 'b');
text(X(1,1), X(2,1), X(3,1), '\leftarrow Transfer Orbit Burn ','FontSize',20);
plot3(X(1,end), X(2,end), X(3,end), 'ok', 'MarkerFaceColor', 'r');
plot3(XT(1,1:2500), XT(2,1:2500), XT(3,1:2500), 'k', 'LineWidth', 2,'DisplayName','Transfer Orbit');

% plot3(XT(1,1), XT(2,1), XT(3,1), 'ok', 'MarkerFaceColor', 'b');
% plot3(XT(1,end), XT(2,end), XT(3,end), 'ok', 'MarkerFaceColor', 'r');

% plot3(XT2(1,:), XT2(2,:), XT2(3,:), 'b', 'LineWidth', 2);
% plot3(XT2(1,1), XT2(2,1), XT2(3,1), 'ok', 'MarkerFaceColor', 'b');
% plot3(XT2(1,end), XT2(2,end), XT2(3,end), 'ok', 'MarkerFaceColor', 'r');

plot3(XT3(1,:), XT3(2,:), XT3(3,:), 'm', 'LineWidth', 2,'DisplayName','Geostationary Orbit');

plot3(XT3(1,2500), XT3(2,2500), XT3(3,2500), 'ok', 'MarkerFaceColor', 'b');

text(XT3(1,2500), XT3(2,2500), XT3(3,2500), '\leftarrow Circularisation and Deinclination Burn','FontSize',20);

% plot3(XT3(1,end), XT3(2,end), XT3(3,end), 'ok', 'MarkerFaceColor', 'r');


