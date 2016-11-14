%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 6.
%% ������������� ������������ ������� ���
%% ��������� ��������� ��������� ����������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;

%% ������������� ��������� %%
%�������� �������� ��������
x_true = 10;                        %��� ����������
%��������� �������������� ��������
x_exp = 1e2*randn; %��� ����������

%��������� ��������� ������
sn = 5; %���������� ���������
x_var_max = 2;                      %��� ���������� 100
x_var_min = -3;                     %��� ���������� 0.001
x_var = logspace(x_var_min,x_var_max,sn);


%���������� ���������
mn = 100;

%��������� ���������
m_var = 10;                         %��� ����������

%�������������
y = x_true+sqrt(m_var)*randn(1,mn);

x_est = zeros(sn,mn);
%% ���������� %%
for j=1:sn
for i=1:mn
x_est(j,i) = (x_exp+(x_var(j)/(x_var(j)+(1/i)*m_var))*(sum(y(1:i)-x_exp))/i);
end
end
    
%% ������� %%
figure(1); clf;
hold on; grid;
plot(y,'*','DisplayName','y');
for i = 1:sn
plot(1:mn,x_est(i,:),'DisplayName',['$\sigma^2_0$ = ' num2str(x_var(i))]);
end
plot(x_exp,'or','DisplayName','$\widehat{x}_0$');
I = legend(gca,'show');
set(I,'interpreter','latex');

%% ������ ������ %%
T = table(y','VariableNames',{'Measurements'});
writetable(T,'week6.txt','Delimiter',' ')

