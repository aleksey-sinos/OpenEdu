/////////////////////////////////////////////////////////
//// Неделя 6.
//// Использование байесовского подхода при
//// различных значениях априорной неопределенности
/////////////////////////////////////////////////////////
clear; exec roundd.sci;

//априорное математическое ожидание
x_exp = -24; 

//дисперсия априорной оценки
sn = 5; //количество вариантов
x_var_max = 2;
x_var_min = -3;
x_var = logspace(x_var_min,x_var_max,sn);

//чтение данных
data=read('data.txt',mn,1);

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

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
data = y';
answer = [x_est(1,$)'; x_est(sn,$)'];
fillings = [x_exp; m_var];

write('data.txt',data);
write('answer.txt',answer);
write('fillings.txt',fillings);

