%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 9.
%% Фильтрация случайных последовательностей.
%% Дискретный фильтр Калмана
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% Параметры  %%

mn = 100; %Количество измерений

%% Моделирование измерений для самолета%%
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

%% Оцениваине высоты %%
H = [1 0];
G = [0; 0.5];
           
P_0_est =[1000000 0;
            0     25];
x_est = zeros(2,mn); x_est(:,1) = [5000, 2]; 
z = zeros(1,mn-1);
P_est = zeros(2,2,mn); P_est(:,:,1) = P_0_est;

for i = 2:mn
    P_pr = F*P_est(:,:,i-1)*F' + G*Q*G'; % Матрица ковариаций прогноза
    P_est(:,:,i) = (P_pr^-1 + H'*(R^-1)*H)^-1; % Матрица ковариаций оценки
    K = P_est(:,:,i)*H'*R^-1; % Коэфициент усиления

    x_est(:,i) = F*x_est(:,i-1) + K*(y(i-1) - H*F*x_est(:,i-1)); % Оценка
    z(i-1) = H*x_est(:,i);
end

figure(1); clf;
title('Истинное значение, измерения и оценка высоты')
hold on; grid on;
plot(1:mn,x(1,:),'b');
plot(2:mn,y,'*');
plot(2:mn,z);
xlabel('Время (c)'); ylabel('Высота (м)');
legend('Истинная траектория','Измерения','Оценка');

figure(2); clf;

subplot(1,2,1); hold on; grid; title('СКО вертикальной скорости')
plot(1:mn,3*sqrt(squeeze(P_est(2,2,:))),'r');
plot(1:mn,-3*sqrt(squeeze(P_est(2,2,:))),'r');
ylabel('СКО (м/с)');
legend('3\sigma оценки');

subplot(1,2,2); hold on; grid; title('СКО высоты')
h(1) = plot(1:mn,3*sqrt(squeeze(P_est(1,1,:))),'r');
plot(1:mn,-3*sqrt(squeeze(P_est(1,1,:))),'r');
h(2) = plot(1:mn,3*sqrt(R)*ones(1,mn),'b');
plot(1:mn,-3*sqrt(R)*ones(1,mn),'b');
ylim([-50 50]); ylabel('СКО (м)');
legend(h(:),'3\sigma оценки','3\sigma измерений');







