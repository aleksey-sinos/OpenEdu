//////////////////////////////////////////////////////////////////////////////////////////////////////
//// Неделя 4.
//// Оценивание константы обобщенным методом наименьших квадратов
//// при наличии двух измерителей с различной дисперсией.
//// Количество измерений для датчиков одинаково.
//////////////////////////////////////////////////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');

//// Моделирование измерений ////
grand("setsd",getdate("s"))
//истинное значение величины
x = roundd(grand(1,1,"nor", 1, 100),2);

//количество измерений
mn = 100;

//Дисперсия измерителей 
s1_var = abs(roundd(grand(1,1,"nor", 0.5, 0.1),2));
s2_var = abs(roundd(grand(1,1,"nor", 3, 0.2),2));

//Моделирование
s1_m = x+sqrt(s1_var)*rand(1,mn,"normal");
s2_m = x+sqrt(s2_var)*rand(1,mn,"normal");

x_est = zeros(mn,1);
//// Оценивание ////
for i=1:mn
x_est(i) = ((s2_var/(s1_var+s2_var))/i)*sum(s1_m(1:i))+...
        ((s1_var/(s1_var+s2_var))/i)*sum(s2_m(1:i));
end

//// Запись данных //// 
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
s_data = [s1_m';s2_m'];
write('data.txt', s_data);
write('answer.txt', x_est(mn))
write('fillings.txt', [s1_var;s2_var]);

quit();



