%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 5
%% ���������� � �������������� ������ ��������� ������� �������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;

%% ������������� ��������� %%
%���������� ���������
mn=100;
%�������� �������� ��������
x_true=randn*10;

%��� ���������� 0.5
v=rand(1,mn)-0.5;  %��������� ������� � ����������� �������������� (-0,5  0,5)
y=x_true*ones(1,mn)+v;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��������� ������
x_ma=zeros(1,mn);                                   
      

%% ���������� %%
for i=1:mn
x_ma(i)= (1/i)*sum(y(1:i)); %������� �������������� (��� ���������)
x_MLE_Up(i)=min(y(1:i))+0.5;
x_MLE_Down(i)=max(y(1:i))-0.5;
end

%% ������� %%

figure(1)
plot(1:mn,y,'b.',1:mn,x_true*ones(1,mn),...
    'r.',1:mn,x_ma,1:mn,x_MLE_Up,'g',1:mn,x_MLE_Down,'g');
hold on; grid;
legend('���������','�������� ��������','������� ��������������','������� ������ ���');
title('���������� �� ������ ��������� ������� �������������');

fprintf('�������� ������� %.3f \n',x_true);
fprintf('������ ������: %.3f �����: %.3f \n',x_MLE_Up(mn),x_MLE_Down(mn));



%% ������ ������ %%
data = y';
answer = x_MLE_Up(mn);
save('data5.txt','data','-ascii');
save('answer5.txt','answer','-ascii');


