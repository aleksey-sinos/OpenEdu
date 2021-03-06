////////////////////////////////////////////////////////////////////////////////
//// Неделя 8.
//// Формирующий фильтр.
//// Моделирование динамики матрицы ковариаций в байесовском подходе.
//// Рекуррентный  метод. Векторный случай
////////////////////////////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');
rand("seed",getdate("s")); grand("setsd",getdate("s"));

//// Параметры  ////

mn = 100; //Количество измерений

dt = 1;         //Интервал дискретизации
x_0 = [roundd(5000+rand(1,'nor')*100,1); roundd(rand(1,'nor')*3,1)]; //Начальное значение
P_0 = [10 0;   //Начальная матрица ковариаций
    0 0.1];     
F = [1 dt;      //Матрица динамики
    0 1];
G = [0; roundd(0.5+rand(1,'uin'),2)];//Матрица шумов

Q = 1; //Матрица ковариаций шумов

//Выделение памяти
x = zeros(2,mn); x(:,1) = x_0;
x_ex = zeros(2,mn,5);
P = zeros(2,2,mn); P(:,:,1) = P_0;

//// Моделирование ////
//Мат. ожидание и матрица ковариаций
for i = 2:mn
    x(:,i) = F*x(:,i-1);
    P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end
//Реализации
for j = 1:5
    x_ex(:,1,j) = x_0+sqrt(P_0)*rand(2,1,'nor');
    for i = 2:mn
        x_ex(:,i,j) =F*x_ex(:,i-1,j)+sqrt(G)*rand(1,'nor');
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

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
answer = [x(1,100); 3*sqrt(squeeze(P(1,1,100)));find(3*sqrt(P(1,1,:))>300,1)];
fillings = [x_0; G(2)];

write('answer.txt',answer);
write('fillings.txt',fillings);
write('data.txt',[]);

