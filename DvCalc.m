clear; clc; close all

%% Hohmann Transfer

%Base Values
d2r = pi/180;
mu = 398600.4418;
Re = 6378.137;
Orbit_Set = [6678.137, 62; 6678.137, 83; 6608.137, 70];
DVT = zeros(1,3);
Transfer_Time= zeros(1,3);

for i = (1:3)
    %Inital Orbital Conditions
    inc = Orbit_Set(i,2);
    RAAN = 0;
    argp = 0;
    a = Orbit_Set(i,1);
    e = 0;
    coe1 = [a,e,inc,RAAN,argp,0];
    
    %Final Orbital Conditions
    F_inc = 0;
    F_RAAN = 0;
    F_argp = 0;
    F_a = 42164;
    F_e = 0;
    coe4 = [F_a,F_e,F_inc,F_RAAN,F_argp,180*d2r];
    
    
    %Intermediate Orbit
    Ic = IncChange(F_a,a,inc);
    I_Ap = 42164;
    I_Pe = a;
    I_inc = inc-Ic;
    I_a = (I_Ap+I_Pe)/2;
    I_e = (I_Ap-I_Pe)/(I_Ap+I_Pe);
    coe2 = [I_a,I_e,I_inc,0,0,0];
    
    %Burn 1
    BaseVector = COE2RV(coe1,mu);
    TansferVector = COE2RV(coe2,mu);
    BVel = BaseVector(1,4:end);
    TVel = TansferVector(1,4:end);
    DV1 = TVel-BVel;
    DV1 = norm(DV1);
    
    
    %Burn 2
    coe3 = [I_a,I_e,I_inc,0,0,180*d2r];
    TansferVectorAp = COE2RV(coe3,mu);
    FinalVectorAp = COE2RV(coe4,mu);
    TAVel = TansferVectorAp(1,4:end);
    FAVel = FinalVectorAp(1,4:end);
    DV2 = TAVel-FAVel;
    DV2 = norm(DV2);
    
    BurnV(1,i) = DV1;
    BurnV(2,i) =DV2;

    DVT(i) = DV1 + DV2;
    
    T_OrbP = 2*pi*sqrt((I_a)^3/(mu));
    
    Transfer_Time(i) = T_OrbP/2;
end
%% BI_Elliptic Graph V1

Apogee_Array = linspace(45000,350000,100);
BDvTA = zeros(3,100);
Transfer_Time_BI = zeros(3,100);
BDvTADiff = zeros(3,100);
for ii = (1:3)
    for i = (1:100)

        %Base set 
        coe1 = [Orbit_Set(ii,1),0,Orbit_Set(ii,2),RAAN,argp,0];
        BaseVector = COE2RV(coe1,mu);
        BVel = BaseVector(1,4:end);
        

        %1st Transfer Orbit
        BI_Ap = Apogee_Array(i);
        BI_Pe = Orbit_Set(ii,1);
        BI_a = (BI_Ap+BI_Pe)/2;
        BI_e = (BI_Ap-BI_Pe)/(BI_Ap+BI_Pe);
        BI_Inc = Orbit_Set(ii,2) - Ic;
        Bcoe1 = [BI_a,BI_e,BI_Inc,0,0,0];
        
        %2nd Transfer Orbit
        BI2Ap = BI_Ap;
        BI2Pe = 42164;
        BI2a = (BI2Ap+BI2Pe)/2;
        BI2e = (BI2Ap-BI2Pe)/(BI2Ap+BI2Pe);
        BI2Inc = 0;
        Bcoe3 = [BI2a,BI2e,BI2Inc,0,0,180*d2r];
        Bcoe4 = [BI2a,BI2e,BI2Inc,0,0,0];
        
        %Burn 1
        BI1Vec = COE2RV(Bcoe1,mu);
        BI1Vel = BI1Vec(1,4:end);
        BDV1 = BI1Vel - BVel;
        BDV1 = norm(BDV1);
        
        %Burn 2
        Bcoe2 = [BI_a,BI_e,BI_Inc,0,0,180*d2r];
        BI1VecAp = COE2RV(Bcoe2,mu);
        BI1VelAp = BI1VecAp(1,4:end);
        BI2VecAp = COE2RV(Bcoe3,mu);
        BI2VelAp = BI2VecAp(1,4:end);
        BDV2 = BI2VelAp - BI1VelAp; 
        BDV2 = norm(BDV2);
        
        %Burn 3
        Bcoe5 = [F_a,F_e,F_inc,F_RAAN,F_argp,0];
        BI2VecPe = COE2RV(Bcoe4,mu);
        BI2VelPe = BI2VecPe(1,4:end);
        BFVecPe = COE2RV(Bcoe5,mu);
        BFVelPe = BFVecPe(1,4:end);
        BDV3 = BI2VelPe-BFVelPe;
        BDV3 = norm(BDV3);

       
        BDvTA(ii,i) = BDV1 + BDV2 + BDV3;
        BDvTADiff(ii,i) = DVT(1,ii) - BDvTA(ii,i);
        T1_OrbPB = 2*pi*sqrt((BI_a)^3/(mu));
    
        T2_OrbPB = 2*pi*sqrt((BI2a)^3/(mu));
    
        Transfer_Time_BI(ii,i) = (T1_OrbPB/2)+(T2_OrbPB/2);
    end
end
BDvTADiffD = BDvTADiff;
BDvTADiffD(1:3,101) = BDvTADiffD(1:3,100) + 0.01;


DiffDiff = zeros(3,100);

for i = (1:100)
    DiffDiff(1,i) = BDvTADiffD(1,i)/BDvTADiffD(1,i+1);
end

for i = (1:100)
    DiffDiff(2,i) = BDvTADiffD(2,i)/BDvTADiffD(2,i+1);
end

for i = (1:100)
    DiffDiff(3,i) = BDvTADiffD(3,i)/BDvTADiffD(3,i+1);
end

i = 1;

while i < 101
    if DiffDiff(1,i) > 0.99
        OrbitValues(1,1) = BDvTA(1,i);
        OrbitValues(1,2) = Transfer_Time_BI(1,i);
        OrbitValues(1,3) = i;
        break
    end
    i = i + 1;
end

i = 1;
while i < 101
    if DiffDiff(2,i) > 0.99
        OrbitValues(2,1) = BDvTA(2,i);
        OrbitValues(2,2) = Transfer_Time_BI(2,i);
        OrbitValues(2,3) = i;
        break
    end
    i = i + 1;
end

i = 1;
while i < 101
    if DiffDiff(3,i) > 0.99
        OrbitValues(3,1) = BDvTA(3,i);
        OrbitValues(3,2) = Transfer_Time_BI(3,i);
        OrbitValues(3,3) = i;
        break
    end
    i = i + 1;
end


figure
plot(Apogee_Array,BDvTADiff(1,:),'DisplayName','SaxaVord')
hold on
plot(Apogee_Array,BDvTADiff(2,:),'DisplayName','Sutherland')
plot(Apogee_Array,BDvTADiff(3,:),'DisplayName','Cornwall')
title('Plot of Transfer Radius Against Delta-v Reduction for Bi-Elliptic Transfer Against Hohmann Transfer')
xlabel('Transfer Radius (Km)')
ylabel('Delta V Expenditure Difference (Km/s)')
text(Apogee_Array(OrbitValues(1,3)),BDvTADiff(1,OrbitValues(1,3)),'\leftarrow Chosen Transfer Orbit')
text(Apogee_Array(OrbitValues(2,3)),BDvTADiff(2,OrbitValues(2,3)),'\leftarrow Chosen Transfer Orbit')
text(Apogee_Array(OrbitValues(3,3)),BDvTADiff(3,OrbitValues(3,3)),'\leftarrow Chosen Transfer Orbit')
legend
hold off

figure
plot(Apogee_Array,Transfer_Time_BI(1,:),'DisplayName','Flight Time from Inital to GEO')
title('Time of Flight against Transfer Radius for Bi-Elliptic Transfer')
xlabel('Transfer Radius (Km)')
ylabel('Time of Flight (s)')
legend
hold on
