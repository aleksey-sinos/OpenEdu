%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 9.
%% ���������� ��������� �������������������.
%% ���������� ������ �������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% ���������  %%

mn = 100; %���������� ���������

%% ������������� ��������� ��� ��������%%
dt = 1;
x_0 = [3000;2];
P_0 = [100 0;
        0 0.5];
F = [1 dt;
     0 1];
G = [0; 0.5];

Q = 1;
R = 10^2;


x = zeros(2,mn); 
y = zeros(1,mn-1); 
P = zeros(2,2,mn); P(:,:,1) = P_0;

x(:,1) = x_0+sqrt(P_0)*randn(2,1);
for i = 2:mn
   x(:,i) =F*x(:,i-1)+G*randn;
   y(i-1) = x(1,i)+sqrt(R)*randn;
   P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end

%% ���������� ������ %%
H = [1 0];
G = [0; 0.5];
           
P_0_est =[1000000 0;
            0     25];
x_est = zeros(2,mn); x_est(:,1) = [5000, 2]; 
z = zeros(1,mn-1);
P_est = zeros(2,2,mn); P_est(:,:,1) = P_0_est;

for i = 2:mn
    P_pr = F*P_est(:,:,i-1)*F' + G*Q*G'; % ������� ���������� ��������
    P_est(:,:,i) = (P_pr^-1 + H'*(R^-1)*H)^-1; % ������� ���������� ������
    K = P_est(:,:,i)*H'*R^-1; % ���������� ��������

    x_est(:,i) = F*x_est(:,i-1) + K*(y(i-1) - H*F*x_est(:,i-1)); % ������
    z(i-1) = H*x_est(:,i);
end

figure(1); clf;
title('�������� ��������, ��������� � ������ ������')
hold on; grid on;
plot(1:mn,x(1,:),'b');
plot(2:mn,y,'*');
plot(2:mn,z);
xlabel('����� (c)'); ylabel('������ (�)');
legend('�������� ����������','���������','������');

figure(2); clf;

subplot(1,2,1); hold on; grid; title('��� ������������ ��������')
plot(1:mn,3*sqrt(squeeze(P_est(2,2,:))),'r');
plot(1:mn,-3*sqrt(squeeze(P_est(2,2,:))),'r');
ylabel('��� (�/�)');
legend('3\sigma ������');

subplot(1,2,2); hold on; grid; title('��� ������')
h(1) = plot(1:mn,3*sqrt(squeeze(P_est(1,1,:))),'r');
plot(1:mn,-3*sqrt(squeeze(P_est(1,1,:))),'r');
h(2) = plot(1:mn,3*sqrt(R)*ones(1,mn),'b');
plot(1:mn,-3*sqrt(R)*ones(1,mn),'b');
ylim([-50 50]); ylabel('��� (�)');
legend(h(:),'3\sigma ������','3\sigma ���������');







