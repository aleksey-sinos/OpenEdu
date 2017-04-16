/////////////////////////////////////////////////////////
//// Неделя 6.
//// Использование байесовского подхода при
//// различных значениях априорной неопределенности
/////////////////////////////////////////////////////////

clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');
rand("seed",getdate("s")); grand("setsd",getdate("s"));

//// Моделирование измерений ////
//истинное значение величины
x_true = 10;                        //Для заполнения
//априорное математическое ожидание
x_exp = 3*sign(rand(1,'nor'))*x_true+round(grand(1,1,"nor",0,4)); //Для заполнения

//дисперсия априорной оценки
sn = 5; //количество вариантов
x_var_max = 2;                      //Для заполнения 100
x_var_min = -3;                     //Для заполнения 0.001
x_var = logspace(x_var_min,x_var_max,sn);


//количество измерений
mn = 100;

//Дисперсия измерений
m_var = roundd(10+grand(1,1,"nor",0,1),2);

//Моделирование
y = x_true+sqrt(m_var)*grand(1,mn,"nor",0,1);

x_est = zeros(sn,mn);
//// Оценивание ////
for j=1:sn
for i=1:mn
x_est(j,i) = x_exp+(x_var(j)/(x_var(j)+(1/i)*m_var))*(sum(y(1:i)-x_exp))/i;
end
end
    

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
data = y';
answer = [x_est(1,$)'; x_est(sn,$)'];
fillings = [x_exp; m_var];

write('data.txt',data);
write('answer.txt',answer);
write('fillings.txt',fillings);

quit();

