%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 4.
%% ���������� ��������� ���������� ������� ���������� ���������
%% ��� ������� ���� ����������� � ��������� ����������.
%% ���������� ��������� ��� �������� ���������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear;

%% ������������� ��������� %%
%�������� �������� ��������
x = round(randn*100,2);

%���������� ���������
mn = 100;

%��������� �����������
s1_var = 1;
s2_var = 27;

%�������������
s1_m = x+sqrt(s1_var)*randn(1,mn);
s2_m = x+sqrt(s2_var)*randn(1,mn);

x_est = zeros(1,mn);
%% ���������� %%
for i=1:mn
x_est(i) = ((s2_var/(s1_var+s2_var))/i)*sum(s1_m(1:i))+...
        ((s1_var/(s1_var+s2_var))/i)*sum(s2_m(1:i));
end

%% ������� %%
if sh_plot == 1
    figure(1); clf;
    hold on; grid;
    plot(s1_m,'g*');
    plot(s2_m,'b.');
    plot(1:mn,x_est,'r','linewidth',2);
    legend('sensor 1','sensor 2','estimate')
end

%% ������ ������ %%
if wr_data == 1
    s_data = [s1_m',s2_m'];
    %dlmwrite('s_data.txt',s_data, ',')
    save s_data.txt s_data -ASCII
end


