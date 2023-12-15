clear; clc; close all

%Establising Iterated Arrays
coe = zeros(6,1000);
X = zeros(6,1000);
coeT = zeros(6,1000);
XT = zeros(6,1000);
coeT2 = zeros(6,1000);
XT2 = zeros(6,1000);
coeT3 = zeros(6,1000);
XT3 = zeros(6,1000);
coeT4 = zeros(6,1000);
XT4 = zeros(6,1000);


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
TargetAP = 140505.050505051;
TargetPE = 230;
SMAT = ((TargetAP+Re)+(TargetPE+Re))/2;
EccT = 1-((TargetPE+Re)/SMAT);
TTaTi = TRUPRO(SMAT,mu,EccT);
for tt = 1:length(TTaTi)
    coeT(:,tt) = [SMAT,EccT,inc,RAAN,argp,TTaTi(tt)];
    XT(:,tt) = COE2RV(coeT(:,tt),mu);
end

%Inclination Change
IncT = 0;
TTaTi2 = TRUPRO(SMAT,mu,IncT);

%Draw Inc Change
for tt = 1:length(TTaTi2)
    coeT2(:,tt) = [SMAT,EccT,IncT,RAAN,argp,TTaTi2(tt)];
    XT2(:,tt) = COE2RV(coeT2(:,tt),mu);
end

%Burn to Target Altitude
TargetAPTA = TargetAP;
TargetPETA = 35786;
SMATTA = ((TargetAPTA+Re)+(TargetPETA+Re))/2;
EccTTA = 1-((TargetPETA+Re)/SMATTA);
TTaTI3 = TRUPRO(SMATTA,mu,EccTTA);
for tt = 1:length(TTaTI3)
    coeT3(:,tt) = [SMATTA,EccTTA,IncT,RAAN,argp,TTaTI3(tt)];
    XT3(:,tt) = COE2RV(coeT3(:,tt),mu);
end

%Orbit Circularisation
COTA = 35786;
SMAT2 = ((COTA+Re)+(COTA+Re))/2;
EccT2 = 1-((COTA+Re)/SMAT2);
TTaTi3 = TRUPRO(SMAT2,mu,IncT);
for tt = 1:length(TTaTi3)
    coeT4(:,tt) = [SMAT2,EccT2,IncT,RAAN,argp,TTaTi3(tt)];
    XT4(:,tt) = COE2RV(coeT4(:,tt),mu);
end


%% 3D plot code copied and modified to variables for this code from week 2 EEE3039_KeplerGraphic.M by Nicola Baresi  

[Xe,Ye,Ze] = sphere(50);

% Create figure
figure('units','normalized','outerposition',[0 0 1 1])

% Plot Earth
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
title('Bi-Elliptic Transfer Sutherland Space Hub','FontSize',20)

% Plot Trajectory
plot3(X(1,:), X(2,:), X(3,:), 'r--', 'LineWidth', 2);
plot3(X(1,1), X(2,1), X(3,1), 'ok', 'MarkerFaceColor', 'b');
text(X(1,1), X(2,1), X(3,1), '\leftarrow Transfer Orbit Burn','FontSize',20);
% plot3(X(1,end), X(2,end), X(3,end), 'ok', 'MarkerFaceColor', 'r');

plot3(XT(1,1:2500), XT(2,1:2500), XT(3,1:2500), 'k', 'LineWidth', 2);
plot3(XT(1,2500), XT(2,2500), XT(3,2500), 'ok', 'MarkerFaceColor', 'b');
text(XT(1,2500), XT(2,2500), XT(3,2500),'\leftarrow Perigee Raise and Deinclination Burn','FontSize',20);
% plot3(XT(1,end), XT(2,end), XT(3,end), 'ok', 'MarkerFaceColor', 'r');

% plot3(XT2(1,1:2500), XT2(2,1:2500), XT2(3,1:2500), 'b', 'LineWidth', 2);
% plot3(XT2(1,2500), XT2(2,2500), XT2(3,2500), 'ok', 'MarkerFaceColor', 'b');
% plot3(XT2(1,end), XT2(2,end), XT2(3,end), 'ok', 'MarkerFaceColor', 'r');

plot3(XT3(1,2500:5000), XT3(2,2500:5000), XT3(3,2500:5000), 'g', 'LineWidth', 2);
plot3(XT3(1,5000), XT3(2,5000), XT3(3,5000), 'ok', 'MarkerFaceColor', 'b');
text(XT3(1,5000), XT3(2,5000), XT3(3,5000),'\leftarrow Circularisation Burn','FontSize',20);
% plot3(XT3(1,end), XT3(2,end), XT3(3,end), 'ok', 'MarkerFaceColor', 'r');

plot3(XT4(1,:), XT4(2,:), XT4(3,:), 'm', 'LineWidth', 2);
% plot3(XT4(1,5000), XT4(2,5000), XT4(3,5000), 'ok', 'MarkerFaceColor', 'b');
% plot3(XT4(1,end), XT4(2,end), XT4(3,end), 'ok', 'MarkerFaceColor', 'r');


%Label Apoapsis and Periapsis
% text(XT(1,ApPe(2,1)),XT(2,ApPe(2,1)),XT(3,ApPe(2,1)),'Apoapsis')
% text(XT(1,ApPe(1,1)),XT(2,ApPe(1,1)),XT(3,ApPe(1,1)),'Periapsis')
% 
% text(XT3(1,ApPe(1,1)),XT3(2,ApPe(1,1)),XT3(3,ApPe(1,1)),'Periapsis')

