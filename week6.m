%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 6.
%% ������������� ������������ ������� ���
%% ��������� ��������� ��������� ����������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

%% ������������� ��������� %%
%��������� �������������� ��������
x_exp = 1e2*randn;

%��������� ��������� ������
sn = 5; %���������� ���������
x_var_max = rand*3;
x_var_min = -3;
x_var = logspace(x_var_min,x_var_max,sn);

%�������� �������� ��������
x_true = 3.14;

%���������� ���������
mn = 100;

%��������� ���������
m_var = 10;

%�������������
x_m = x_true+sqrt(m_var)*randn(1,mn);

x_est = zeros(sn,mn);
%% ���������� %%
for j=1:sn
for i=1:mn
x_est(j,i) = (x_exp+(x_var(j)/(x_var(j)+(1/i)*m_var))*(sum(x_m(1:i)-x_exp))/i);
end
end
    
%% ������� %%

figure(1); clf;
hold on; grid;
plot(x_m,'*','DisplayName','measurements');
for i = 1:sn
plot(1:mn,x_est(i,:),'DisplayName',['var =' num2str(x_var(i))]);
end
plot(x_exp,'or','DisplayName','x exp');
legend(gca,'show');
