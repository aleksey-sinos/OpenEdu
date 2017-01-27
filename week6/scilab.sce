/////////////////////////////////////////////////////////
//// Неделя 6.
//// Использование байесовского подхода при
//// различных значениях априорной неопределенности
/////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');

//априорное математическое ожидание
x_exp = ...; 

//дисперсия априорной оценки
sn = 5; //количество вариантов априорной дисперсии
x_var_max = 2; // соответствует sigma^2_0 = 100
x_var_min = -3; //соответствует sigma^2_0 = 0.001
x_var = logspace(x_var_min,x_var_max,sn);

//количество измерений
mn = 100;

//чтение данных
y=read('data.txt',mn,1);

//Дисперсия измерений
m_var = ...;

x_est = zeros(sn,mn);
//// Оценивание ////
for j=1:sn
for i=1:mn
x_est(j,i) = ...;
end
end
    
//// Графики ////
figure(1); clf;
set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
plot2d(1:mn,y,-10);
for i = 1:sn
plot2d(1:mn,x_est(i,:),i);
end
legend(['y';'sigma^2_0 = '+msprintf('%.3f',x_var(1));'sigma^2_0 = '+msprintf('%.2f',x_var(2));...
'sigma^2_0 = '+msprintf('%.2f',x_var(3));'sigma^2_0 = '+msprintf('%.2f',x_var(4));'sigma^2_0 = '+msprintf('%.2f',x_var(5))]);

mprintf('Оценка при sigma^2_0 = 0.001: %f \n',x_est(1,$));
mprintf('Оценка при sigma^2_0 = 100: %f \n',x_est(sn,$));

