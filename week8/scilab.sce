////////////////////////////////////////////////////////////////////////////////
//// Неделя 8.
//// Формирующий фильтр.
//// Моделирование динамики матрицы ковариаций в байесовском подходе.
//// Рекуррентный  метод. Векторный случай
////////////////////////////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');
//// Параметры  ////

mn = 100; //Количество измерений

dt = 1;         //Интервал дискретизации
x_0 = [roundd(5000+rand(1,'nor')*100,1); roundd(rand(1,'nor')*3,1)]; //Начальное значение
P_0 = [10 0;   //Начальная матрица ковариаций
    0 0.1];     
F = [1 dt;      //Матрица динамики
    0 1];
G = [0; roundd(0.5+rand(1,'uin'),1)];//Матрица шумов

Q = 1; //Матрица ковариаций шумов

//Выделение памяти
x = zeros(2,mn); x(:,1) = x_0;
P = zeros(2,2,mn); P(:,:,1) = P_0;

//// Моделирование ////
//Мат. ожидание и матрица ковариаций
for i = 2:mn
    x(:,i) = F*x(:,i-1);
    P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
end

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
answer = [x(1,$); 3*sqrt(squeeze(P(1,1,$)));find(3*sqrt(P(1,1,:))>300,1)];
fillings = [x_0; G(2)];

write('answer.txt',answer);
write('fillings.txt',fillings);

quit();



