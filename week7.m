%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 7.
%% ����������� ��������� ���� ����������� � �������������� ������������ �������.
%% ������������ �������� � ������� ������� ����������.
%% �������������� �����.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% ���������  %%
mn = 50; %���������� ���������

h0_var = round(10+randn*2,1); %��������� ��������� ������ ������ %��� ����������
V_var = round(5+randn*2,1); %��������� ��������� ������ �������� %��� ����������

h0 = 1000+sqrt(h0_var)*randn;  %�������� �������� ��������
V = sqrt(V_var)*randn;         %�������� �������� ��������

%��������� �����������
SNS_var = abs(round(2+randn,2));    %��� ����������
BA_var = abs(round(4+randn,2));    %��� ����������

%% ������������� ��������� �������� � ��������� %%
h = (h0+V*(0:mn-1))';
y_sns = h+sqrt(SNS_var)*randn(mn,1);
y_ba = h+sqrt(BA_var)*randn(mn,1);


%% ���������� %%
h0_exp = 1000;  %��������� �������������� �������� 
V_exp = 0;      %��������� �������������� �������� 
x0 = [h0_exp; V_exp];
P_x = [h0_var 0; 0 V_var]; %��������� ������� ���������� �

%��������� ������
P = zeros(2,2,mn);
P_ba = zeros(2,2,mn);
x_est = zeros(2,mn);

for i = 1:mn
%������������ ������� ����������
H = ones(i,2); 
H(:,2) = 0:i-1;

% ������ ������� ���������� %
R_sns = eye(i)*SNS_var; %������� ���������� ������ ���
R_ba = eye(i)*BA_var;  %������� ���������� ������ ��������������
P(:,:,i) = (P_x^-1 + H'*R_sns^-1*H+H'*R_ba^-1*H)^-1; %������� ���������� ������� ����������
P_ba(:,:,i) = (P_x^-1 + H'*R_ba^-1*H)^-1; %������� ���������� ������� ���������� ��� ���������� ��������� SNS

%������
x_est(:,i) = x0+P(:,:,i)*(H'*R_sns^-1*(y_sns(1:i)-H*x0)+H'*R_ba^-1*(y_ba(1:i)-H*x0));
end

%���������� ��� ���������� ��� ������� ������ ���������
h_f_sko = squeeze(sqrt(P(1,1,1:mn)));
v_f_sko = squeeze(sqrt(P(2,2,1:mn)));

%���������� ��� ���������� ��� ���������� SNS
h_b_sko = squeeze(sqrt(P_ba(1,1,1:mn)));
v_b_sko = squeeze(sqrt(P_ba(2,2,1:mn)));

%�������������� ������ ����������
h_est_err = x_est(1,:)-h0;
V_est_err = x_est(2,:)-V;

%% ������� %%
figure(1); clf;
subplot(2,1,1);
title('3\sigma ������ ������ ��������� ������')
hold on; grid; xlabel('� ���������'); ylabel('�');
plot(1:mn,3*h_f_sko,'b',1:mn, 3*h_b_sko,'r',1:mn,h_est_err,'g',1:mn,-3*h_f_sko,'b',1:mn,-3*h_b_sko,'r');

legend('3\sigma ������ � ���','3\sigma ������ ��� ���','�������������� ������')

subplot(2,1,2);
title('3\sigma ������ ������ ������������ ��������')
hold on; grid; xlabel('� ���������'); ylabel('�/�');
plot(1:mn,3*v_f_sko,'b',1:mn,3*v_b_sko,'r',1:mn,V_est_err,'g',1:mn,-3*v_f_sko,'b',1:mn,-3*v_b_sko,'r');
legend('3\sigma �������� � ���','3\sigma �������� ��� ���','�������������� ������')

fprintf('������� ���������� ������ ����������� ����� %g ���������: \n',mn);
disp(P(:,:,mn));

fprintf('3 ����� ������ ����� %g ���������: %g \n',mn,h_f_sko(mn));
fprintf('3 ����� ������������ �������� � ��� ����� %g ���������: %g \n',mn, v_f_sko(mn));
fprintf('3 ����� ������������ �������� ��� ��� ����� %g ���������: %g \n',mn, v_b_sko(mn));

%% ������ ������ %%
data = [y_sns, y_ba];
answer = [x_est(1,end); x_est(2,end); 3*h_f_sko(20); 3*v_b_sko(20)];
fillings = [h0_var; V_var; SNS_var; BA_var];

save('data7.txt','data','-ascii');
save('answer7.txt','answer','-ascii');
save('fillings7.txt','fillings','-ascii');







