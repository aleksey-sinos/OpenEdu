%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ 8.
%% ����������� ������.
%% ������������� �������� ������� ���������� � ����������� �������.
%% ������������  �����. ��������� ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% ���������  %%

mn = 100; %���������� ���������

dt = 1;         %�������� �������������
x_0 = [round(5000+rand*100,1);round(randn*3,1)]; %��������� ��������
P_0 = [10 0;   %��������� ������� ����������
    0 0.1];     
F = [1 dt;      %������� ��������
    0 1];
G = [0; round(0.5+rand,1)];%������� �����

Q = 1; %������� ���������� �����

%��������� ������
x = zeros(2,mn); x(:,1) = x_0;
x_ex = zeros(2,mn,5);
P = zeros(2,2,mn); P(:,:,1) = P_0;

%% ������������� %%
%���. �������� � ������� ����������
for i = 2:mn
    x(:,i) = F*x(:,i-1);
    P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end
%����������
for j = 1:5
    x_ex(:,1,j) = x_0+sqrt(P_0)*randn(2,1);
    for i = 2:mn
        x_ex(:,i,j) =F*x_ex(:,i-1,j)+G*randn;
    end
end

%% ������� %%
figure(1); clf;
subplot(2,1,2);
title('�������� � ��� ������')
hold on; grid;
h(1) = plot(1:mn,x(1,:),'b');
h(2) = plot(1:mn,3*sqrt(squeeze(P(1,1,:)))+x(1,:)','r');
plot(1:mn,-3*sqrt(squeeze(P(1,1,:)))+x(1,:)','r');
for j = 1:5
    h(3) = plot(1:mn,x_ex(1,:,j),'g');
end
legend(h(:),'�������������� ��������','3\sigma','������� ��������� ����������');

subplot(2,1,1);
title('�������� � ��� ������������ ��������')
hold on; grid;
h(1) = plot(1:mn,x(2,:),'b');
h(2) = plot(1:mn,3*sqrt(squeeze(P(2,2,:)))+x(2,:)','r');
plot(1:mn,-3*sqrt(squeeze(P(2,2,:)))+x(2,:)','r');
for j = 1:5
    h(3) = plot(1:mn,x_ex(2,:,j),'g');
end
legend(h(:),'�������������� ��������','3\sigma','������� ��������� ����������');
fprintf('3*��� > 300 ����� %f ������ \n',find(3*sqrt(P(1,1,:))>300,1));

%% ������ ������ %%
answer = [x(1,end); 3*sqrt(squeeze(P(1,1,end)));find(3*sqrt(P(1,1,:))>300,1)];
fillings = [x_0; G(2)];

save('answer8_2.txt','answer','-ascii');
save('fillings8_2.txt','fillings','-ascii');



