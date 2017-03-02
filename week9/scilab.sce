/////////////////////////////////////////////////////////////////////////////////////////////
//// Неделя 9.
//// Фильтрация случайных последовательностей.
//// Дискретный фильтр Калмана.
/////////////////////////////////////////////////////////////////////////////////////////////
clear; xdel(winsid())
deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');
rand("seed",getdate("s")); grand("setsd",getdate("s"));

//// Параметры  ////

mn = 100; //Количество измерений
b_size = mn+1;
//// Моделирование измерений для самолета ////
dt = 1;             //Интервал дискретизации
x_0 = [5000;0];     //Начальное значение
P_0 = [10 0;       //Начальная матрица ковариаций
        0 1];
F = [1 dt;          //Матрица динамики
     0 1];
G = [0; roundd(0.5+0.1*rand(1,'nor'),2)];       //Матрица порождающих шумов

Q = 1;              //Матрица ковариаций порождающий шумов
R = roundd((1+0.3*rand(1,'nor'))^2,2);            //Матрица ковариаций шумов измерений

//Выделение памяти
x = zeros(2,b_size); 
y = zeros(1,b_size); y(1) = %nan;
P = zeros(2,2,b_size); P(:,:,1) = P_0;


x(:,1) = x_0+sqrt(P_0)*rand(2,1,'nor'); //Генерация случайного начального значения
for i = 2:b_size
   x(:,i) =F*x(:,i-1)+sqrt(G)*rand(1,'nor');
   y(i) = x(1,i)+sqrt(R)*rand(1,'nor');
   P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end

//// Оценивание высоты ////
H = [1 0];          //Матрица наблюдения

//Выделение памяти
x_est = zeros(2,b_size); 
z = zeros(1,b_size);
P_est = zeros(2,2,b_size);


//Инициализация алгоритма
x_est(:,1) = x_0;  
P_est(:,:,1) = P_0; //Начальная матрица ковариаций

z(1) = H*x_est(:,1);
//ФК
for i = 2:b_size
    P_pr = F*P_est(:,:,i-1)*F' + G*Q*G'; // Матрица ковариаций прогноза
    P_est(:,:,i) = (P_pr^-1 + H'*(R^-1)*H)^-1; // Матрица ковариаций оценки
    K = P_est(:,:,i)*H'*R^-1; // Коэфициент усиления

    x_est(:,i) = F*x_est(:,i-1) + K*(y(i) - H*F*x_est(:,i-1)); // Оценка
    z(i) = H*x_est(:,i);
end

//Действительные ошибки оценивания
h_est_err = x_est(1,:)-x(1,:);
V_est_err = x_est(2,:)-x(2,:);

//// Графики ////
figure(1); clf;
title('Истинное значение, измерения и оценка высоты')
set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
plot(0:mn,x(1,:),'b');
plot(0:mn,y,'r*');
plot(0:mn,z,'g');
xlabel('Время (c)'); ylabel('Высота (м)'); 
legend('Истинная траектория','Измерения','Оценка');

figure(2); clf;

subplot(1,2,1); set(gca(),"auto_clear","off"); xgrid(1,0.1,10); title('СКО вертикальной скорости')
plot(0:mn,3*sqrt(squeeze(P_est(2,2,:)))','r');
plot(0:mn,V_est_err,'g')
plot(0:mn,-3*sqrt(squeeze(P_est(2,2,:)))','r');
ylabel('СКО (м/с)'); xlabel('Время (c)');
legend('3 sigma оценки','Действительная ошибка');

subplot(1,2,2); set(gca(),"auto_clear","off"); xgrid(1,0.1,10); title('СКО высоты')
plot(0:mn,3*sqrt(squeeze(P_est(1,1,:)))','r');
plot(0:mn,-3*sqrt(squeeze(P_est(1,1,:)))','r');
plot(0:mn,3*sqrt(R)*ones(1,b_size),'b');
plot(0:mn,-3*sqrt(R)*ones(1,b_size),'b');
plot(0:mn,h_est_err,'g');
ylabel('СКО (м)'); xlabel('Время (c)');
legend('3 sigma оценки','3 sigma измерений','Действительная ошибка');

mprintf('Отношение СКО погрешности оценивания \nк СКО погрешности измерений: %f / %f = %f \n',sqrt(P_est(1,1,$)),sqrt(R),sqrt(P_est(1,1,$))/sqrt(R));
mprintf('Высота на 50 секунде полета: %f\n',x_est(1,51));

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
data = y';
answer = [x_est(1,51); sqrt(P_est(1,1,$))/sqrt(R)];
fillings = [R; sqrt(G(2))*3];

write('data.txt',data);
write('answer.txt',answer);
write('fillings.txt',fillings);
