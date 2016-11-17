%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 9.
%% Фильтрация случайных последовательностей.
%% Дискретный фильтр Калмана.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% Параметры  %%

mn = 100; %Количество измерений
b_size = mn+1;
%% Моделирование измерений для самолета %%
dt = 1;             %Интервал дискретизации
x_0 = [5000;0];     %Начальное значение
P_0 = [10 0;       %Начальная матрица ковариаций
        0 1];
F = [1 dt;          %Матрица динамики
     0 1];
G = [0; 0.5+0.1*rand];       %Матрица порождающих шумов

Q = 1;              %Матрица ковариаций порождающий шумов
R = (1+0.3*rand)^2;            %Матрица ковариаций шумов измерений

%Выделение памяти
x = zeros(2,b_size); 
y = zeros(1,b_size); y(1) = NaN;
P = zeros(2,2,b_size); P(:,:,1) = P_0;


x(:,1) = x_0+sqrt(P_0)*randn(2,1); %Генерация случайного начального значения
for i = 2:b_size
   x(:,i) =F*x(:,i-1)+G*randn;
   y(i) = x(1,i)+sqrt(R)*randn;
   P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end

%% Оценивание высоты %%
H = [1 0];          %Матрица наблюдения

%Выделение памяти
x_est = zeros(2,b_size); 
z = zeros(1,b_size);
P_est = zeros(2,2,b_size);


%Инициализация алгоритма
x_est(:,1) = x_0;  
P_est(:,:,1) = P_0; %Начальная матрица ковариаций

z(1) = H*x_est(:,1);
%ФК
for i = 2:b_size
    P_pr = F*P_est(:,:,i-1)*F' + G*Q*G'; % Матрица ковариаций прогноза
    P_est(:,:,i) = (P_pr^-1 + H'*(R^-1)*H)^-1; % Матрица ковариаций оценки
    K = P_est(:,:,i)*H'*R^-1; % Коэфициент усиления

    x_est(:,i) = F*x_est(:,i-1) + K*(y(i) - H*F*x_est(:,i-1)); % Оценка
    z(i) = H*x_est(:,i);
end

%Действительные ошибки оценивания
h_est_err = x_est(1,:)-x(1,:);
V_est_err = x_est(2,:)-x(2,:);

%% Графики %%
figure(1); clf;
title('Истинное значение, измерения и оценка высоты')
hold on; grid on;
plot(0:mn,x(1,:),'b');
plot(0:mn,y,'*');
plot(0:mn,z);
xlabel('Время (c)'); ylabel('Высота (м)'); 
legend('Истинная траектория','Измерения','Оценка');

figure(2); clf;

subplot(1,2,1); hold on; grid; title('СКО вертикальной скорости')
plot(0:mn,3*sqrt(squeeze(P_est(2,2,:))),'r');
plot(0:mn,V_est_err,'g')
plot(0:mn,-3*sqrt(squeeze(P_est(2,2,:))),'r');
ylabel('СКО (м/с)'); xlabel('Время (c)');
legend('3\sigma оценки','Действительная ошибка');

subplot(1,2,2); hold on; grid; title('СКО высоты')
h(1) = plot(0:mn,3*sqrt(squeeze(P_est(1,1,:))),'r');
plot(0:mn,-3*sqrt(squeeze(P_est(1,1,:))),'r');
h(2) = plot(0:mn,3*sqrt(R)*ones(1,b_size),'b');
plot(0:mn,-3*sqrt(R)*ones(1,b_size),'b');
h(3) = plot(0:mn,h_est_err,'g');
ylabel('СКО (м)'); xlabel('Время (c)');
legend(h(:),'3\sigma оценки','3\sigma измерений','Действительная ошибка');

fprintf('Отношение СКО погрешности оценивания \nк СКО погрешности измерений: %f / %f = %f \n',sqrt(P_est(1,1,end)),sqrt(R),sqrt(P_est(1,1,end))/sqrt(R));
fprintf('Высота на 50 секунде полета: %f\n',x_est(1,51));

%% Запись данных %%
data = y';
answer = [x_est(1,51); sqrt(P_est(1,1,end))/sqrt(R)];
fillings = [sqrt(R); G(2)*3];

save('data9.txt','data','-ascii');
save('answer9.txt','answer','-ascii');
save('fillings9.txt','fillings','-ascii');
