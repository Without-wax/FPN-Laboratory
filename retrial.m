function [A_Power,R_Power,Frequency,Voltage] = retrial(val)

%% Algorithm 
%Define Base parameters
S_base = 10000; V_base = 381; f_base = 50; I_base = S_base/(sqrt(3)*V_base);
%Define network parameters
r1 = 0.0103; l1 = 0.0262; r2 = 0.0358; l2 = 0.0262;

%Senstivitiy analysis parameters
if(val == 1)
%    value = 0.9869;
   value = 0.5;
 elseif(val == 2)
     value= 1;
 elseif(val == 3)
%     value= 1.0105;
    value = 1.5;
 end
V = [1;1;1]; w = 1; w0 = [1;1;1]; V0 = [1;1;1];
Dw = [100;100;100]; Dv = [20*value;20;20]; load = [0.42,0,0.42];
%Define error margin
error  = ones(2)'*1e-6;
error = error(:);
%Define counter variable
counter = 0;
%Define x vector
x = [V' w];
while 1 && counter < 1000
counter  = counter + 1;
%Calculate Y bus matrix
z1 = r1+l1*w*1i; z2 = r2+l2*w*1i; y1 = 1/z1; y2 = 1/z2;
%y1 = (r1-w*l1*1i)/(r1^2 + (w*l1)^2); y2 = (r2-w*l2*1i)/(r2^2  + (w*l2)^2);
Y = [y1,-y1,0; -y1,y1+y2,-y2; 0,-y2,y2];
%Calculate Real and Imaginary power at Generators and busses
P_0 = (Dw.*(w0-w)); P(1) = P_0(1)-load(1); P(2) = P_0(2)-load(2); P(3) = P_0(3)-load(3);
Q = Dv.*(V0-abs(V));
Qg = Q;
%Calculate Voltage using Modified GS method
%y_kk = (1./diag(Y));
v1 = (1/Y(1,1))*((P(1)-Q(1)*1i)/conj(V(1)) - (Y(1,2)*V(2)) - (Y(1,3)*V(3))); 
v2 = (1/Y(2,2))*((P(2)-Q(2)*1i)/conj(V(2)) - (Y(2,1)*v1) - (Y(2,3)*V(3)));
v3 = (1/Y(3,3))*((P(3)-Q(3)*1i)/conj(V(3)) - (Y(3,1)*v1) - (Y(3,2)*v2));
V = [v1;v2;v3];

%Calculate system Loss
    %Define Currents in the circuit
    I_1 = (V(1)-V(2))*Y(1,2); I_2 = (V(2)-V(3))*Y(2,3);
    %Define line losses
    P_loss = abs(I_1)^2*r1 + abs(I_2)^2*r2; P_load = sum(load);
%Update Frequency
w = (sum(Dw.*w0) - (P_load + P_loss))/sum(Dw);
%Measure change in variable vector and check tolerance level
y = [V' w];
del = abs(y-x)';
x = y;
if (min(del < error))
    I = Y*V;
    break                                                                                                                                                                                                                                                                                                                                                                                                                                                          
end
end
%% Results
I = Y*V;
A_Power = P_0*S_base;
R_Power = Q*S_base;
Frequency = w*f_base;
Voltage = abs(V*V_base);
Current = I;
end