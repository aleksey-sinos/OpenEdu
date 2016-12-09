%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 4.
%% ���������� ��������� ���������� ������� ���������� ���������
%% ��� ������� ���� ����������� � ��������� ����������.
%% ���������� ��������� ��� �������� ���������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;

%% ������������� ��������� %%
%�������� �������� ��������
x = round(randn*100,2);

%���������� ���������
mn = 100;

%��������� �����������
s1_var = abs(round(0.5+0.1*randn,2));             %��� ����������
s2_var = abs(round(3+0.2*randn,2));            %��� ����������

%�������������
s1_m = x+sqrt(s1_var)*randn(1,mn);
s2_m = x+sqrt(s2_var)*randn(1,mn);

x_est = zeros(1,mn);
%% ���������� %%
for i=1:mn
x_est(i) = ((s2_var/(s1_var+s2_var))/i)*sum(s1_m(1:i))+...
        ((s1_var/(s1_var+s2_var))/i)*sum(s2_m(1:i));
end

%% ���������� �� ��������� ����� ���� %%
H = ones(2*mn,1);
Q = blkdiag(eye(mn)*s1_var,eye(mn)*s2_var)^-1;
x_est_m = ((H'*Q*H)^-1)*H'*Q*[s1_m,s2_m]';

fprintf('������: %.3f \n',x_est_m);
fprintf('������� ������ 2-� �������: %f \n',x_est_m-x_est(end));

%% ������� %%
    figure(1); clf;
    hold on; grid;
    plot(s1_m,'g*');
    plot(s2_m,'b.');
    plot(1:mn,x_est,'r','linewidth',2);
    legend('��������� ������� 1','��������� ������� 2','������');
    title('���������� ���������� ���'); xlabel('��������');


%% ������ ������ %%
data = [s1_m',s2_m'];
answer = x_est_m;
fillings = [s1_var; s2_var];

save('data4.txt','data','-ascii');
save('answer4.txt','answer','-ascii');
save('fillings4.txt','fillings','-ascii');



