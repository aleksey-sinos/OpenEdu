//////////////////////////////////////////////////////////////////////////////////////////////////////
//// Неделя 4.
//// Оценивание константы обобщенным методом наименьших квадратов
//// при наличии двух измерителей с различной дисперсией.
//// Количество измерений для датчиков одинаково.
//////////////////////////////////////////////////////////////////////////////////////////////////////

clear; 

//количество измерений
mn = 100;

//Дисперсия измерителей 
s1_var = ...;
s2_var = ...;

//Чтение данных
data = read('data.txt',2*mn,1);
s1_m = data(1:mn)';
s2_m = data(mn+1:$)';

x_est = zeros(mn,1);
//// Оценивание ////
for i=1:mn
x_est(i) = ...;
end

// Оценивание по матричной форме ОМНК //
H = ...;
Q = ...;
x_est_m = ...;

mprintf('Оценка: %f \n',x_est_m);
mprintf('Разница оценок 2-х методов: %f \n',x_est_m-x_est($));

// Графики //
    figure(1); clf;
    set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
    plot(s1_m,'g*');
    plot(s2_m,'b.');
    plot(1:mn,x_est','r','linewidth',2);
    legend('Измерения датчика 1','Измерения датчика 2','Оценка');
    title('Оценивание обобщенным МНК'); xlabel('Изерения');




