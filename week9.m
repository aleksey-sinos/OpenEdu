%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 9.
%% ���������� ��������� �������������������.
%% ���������� ������ �������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% ���������  %%

mn = 100; %���������� ���������
b_size = mn+1;
%% ������������� ��������� ��� �������� %%
dt = 1;             %�������� �������������
x_0 = [5000;0];     %��������� ��������
P_0 = [10 0;       %��������� ������� ����������
        0 1];
F = [1 dt;          %������� ��������
     0 1];
G = [0; 0.5+0.1*rand];       %������� ����������� �����

Q = 1;              %������� ���������� ����������� �����
R = (1+0.3*rand)^2;            %������� ���������� ����� ���������

%��������� ������
x = zeros(2,b_size); 
y = zeros(1,b_size); y(1) = NaN;
P = zeros(2,2,b_size); P(:,:,1) = P_0;


x(:,1) = x_0+sqrt(P_0)*randn(2,1); %��������� ���������� ���������� ��������
for i = 2:b_size
   x(:,i) =F*x(:,i-1)+G*randn;
   y(i) = x(1,i)+sqrt(R)*randn;
   P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end

%% ���������� ������ %%
H = [1 0];          %������� ����������

%��������� ������
x_est = zeros(2,b_size); 
z = zeros(1,b_size);
P_est = zeros(2,2,b_size);


%������������� ���������
x_est(:,1) = x_0;  
P_est(:,:,1) = P_0; %��������� ������� ����������

z(1) = H*x_est(:,1);
%��
for i = 2:b_size
    P_pr = F*P_est(:,:,i-1)*F' + G*Q*G'; % ������� ���������� ��������
    P_est(:,:,i) = (P_pr^-1 + H'*(R^-1)*H)^-1; % ������� ���������� ������
    K = P_est(:,:,i)*H'*R^-1; % ���������� ��������

    x_est(:,i) = F*x_est(:,i-1) + K*(y(i) - H*F*x_est(:,i-1)); % ������
    z(i) = H*x_est(:,i);
end

%�������������� ������ ����������
h_est_err = x_est(1,:)-x(1,:);
V_est_err = x_est(2,:)-x(2,:);

%% ������� %%
figure(1); clf;
title('�������� ��������, ��������� � ������ ������')
hold on; grid on;
plot(0:mn,x(1,:),'b');
plot(0:mn,y,'*');
plot(0:mn,z);
xlabel('����� (c)'); ylabel('������ (�)'); 
legend('�������� ����������','���������','������');

figure(2); clf;

subplot(1,2,1); hold on; grid; title('��� ������������ ��������')
plot(0:mn,3*sqrt(squeeze(P_est(2,2,:))),'r');
plot(0:mn,V_est_err,'g')
plot(0:mn,-3*sqrt(squeeze(P_est(2,2,:))),'r');
ylabel('��� (�/�)'); xlabel('����� (c)');
legend('3\sigma ������','�������������� ������');

subplot(1,2,2); hold on; grid; title('��� ������')
h(1) = plot(0:mn,3*sqrt(squeeze(P_est(1,1,:))),'r');
plot(0:mn,-3*sqrt(squeeze(P_est(1,1,:))),'r');
h(2) = plot(0:mn,3*sqrt(R)*ones(1,b_size),'b');
plot(0:mn,-3*sqrt(R)*ones(1,b_size),'b');
h(3) = plot(0:mn,h_est_err,'g');
ylabel('��� (�)'); xlabel('����� (c)');
legend(h(:),'3\sigma ������','3\sigma ���������','�������������� ������');

fprintf('��������� ��� ����������� ���������� \n� ��� ����������� ���������: %f / %f = %f \n',sqrt(P_est(1,1,end)),sqrt(R),sqrt(P_est(1,1,end))/sqrt(R));
fprintf('������ �� 50 ������� ������: %f\n',x_est(1,51));

%% ������ ������ %%
data = y';
answer = [x_est(1,51); sqrt(P_est(1,1,end))/sqrt(R)];
fillings = [sqrt(R); G(2)*3];

save('data9.txt','data','-ascii');
save('answer9.txt','answer','-ascii');
save('fillings9.txt','fillings','-ascii');
