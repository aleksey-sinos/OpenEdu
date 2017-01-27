////////////////////////////////////////////////////////////////////////////////
//// Неделя 8.
//// Формирующий фильтр.
//// Моделирование динамики матрицы ковариаций в байесовском подходе.
//// Рекуррентный  метод. Векторный случай
////////////////////////////////////////////////////////////////////////////////
clear; 
//// Параметры  ////

mn = 100; //Количество измерений

dt = 1;         //Интервал дискретизации
x_0 = [...; ...]; //Начальное значение
P_0 = ...;   //Начальная матрица ковариаций
         
F = ...;      //Матрица динамики
    
G = ...;//Матрица шумов

Q = 1; //Матрица ковариаций шумов

//Выделение памяти
x = zeros(2,mn); x(:,1) = x_0;
x_ex = zeros(2,mn,5);
P = zeros(2,2,mn); P(:,:,1) = P_0;

//// Моделирование ////
//Мат. ожидание и матрица ковариаций
for i = 2:mn
    x(:,i) = ...;
    P(:,:,i) = ...;
end

//Возможные реализации
for j = 1:5
    x_ex(:,1,j) = x_0+sqrt(P_0)*rand(2,1,'nor');
    for i = 2:mn
        x_ex(:,i,j) =F*x_ex(:,i-1,j)+G*rand(1,'nor');
    end
end

//// Графики ////
figure(1); clf;
subplot(2,1,2);
title('Динамика и СКО высоты')
set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
plot(1:mn,x(1,:),'b');
plot(1:mn,3*sqrt(squeeze(P(1,1,:)))'+x(1,:),'r');
for j = 1:5
    plot(1:mn,x_ex(1,:,j),'g');
end
plot(1:mn,-3*sqrt(squeeze(P(1,1,:)))'+x(1,:),'r');
legend('Математическое ожидание','3 sigma','Примеры возможных реализаций');

subplot(2,1,1);
title('Динамика и СКО вертикальной скорости')
set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
plot(1:mn,x(2,:),'b');
plot(1:mn,3*sqrt(squeeze(P(2,2,:)))'+x(2,:),'r');
for j = 1:5
   plot(1:mn,x_ex(2,:,j),'g');
end
plot(1:mn,-3*sqrt(squeeze(P(2,2,:)))'+x(2,:),'r');
legend('Математическое ожидание','3 sigma','Примеры возможных реализаций');
mprintf('Математическое ожидание высоты через 100 секунд %f \n',x(1,100));
mprintf('3*СКО высоты через 100 секунд %f \n',3*sqrt(squeeze(P(1,1,100))));
mprintf('3*СКО высоты > 300 через %f секунд \n',find(3*sqrt(P(1,1,:))>300,1));


