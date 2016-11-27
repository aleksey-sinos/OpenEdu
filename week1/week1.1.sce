///////////////////////////////////////////////////////////////////////////////
//// Неделя 1.1
//// Случайные величины и методы их описания.
///////////////////////////////////////////////////////////////////////////////
clear; exec roundd.sci;

//// Генерация параметров нормальной ф.п.р.в.////
mu = roundd(rand(1,1,"nor")*10,1);
sigma = roundd(0.1+rand(1,1,"unf")*3,1);

x = mu+0.72;
// Расчет значения ф.п.р.в. //
y = 1/(sigma*sqrt(2*%pi))*exp((-(x-mu)^2)/(2*sigma^2));

//// Запись данных ////
deletefile('fillings.txt'); deletefile('answer.txt');
answer = y;
fillings = [mu; sigma];

write('answer.txt',answer);
write('fillings.txt',fillings);



