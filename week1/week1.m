%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 1.
%% ��������� �������� � ������ �� ��������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;

%% ��������� ���������� ���������� �.�.�.�.%%
%�������� �������� ��������
mu = round(randn*10,1);
sigma = 0.1+round(rand*2,1);
pd = makedist('Normal','mu',mu,'sigma',sigma);

x = round(mu+0.3*randn*sigma,2);
y = 1/(sigma*sqrt(2*pi))*exp((-(x-mu)^2)/(2*sigma^2))

% %% ������ ������ %%
% data = [s1_m',s2_m'];
% answer = x_est_m;
% fillings = [s1_var; s2_var];
% 
% save('data.txt','data','-ascii');
% save('answer.txt','answer','-ascii');
% save('fillings.txt','fillings','-ascii');



