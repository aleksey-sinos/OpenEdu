///////////////////////////////////////////////////////////////////////////////
//// Неделя 1.2
//// Случайные величины и методы их описания.
///////////////////////////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');
rand("seed",getdate("s"));

//// Генерация параметров равномерной ф.п.р.в.////
a = roundd(rand(1,1,"unf"),1);
l = 1+roundd(rand(1,1,"unf"),1);
b = a+l;
x1 = roundd(a+(b-a)/(3+rand(1,1,"unf")*5),1);
x2 = roundd(b-(b-a)/(3+rand(1,1,"unf")*5),1);

Fx1 = (x1-a)/(b-a);
Fx2 = (x2-a)/(b-a);

// Расчет вероятности //
P=Fx2-Fx1;

//// Запись данных ////
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
answer = P;
fillings = [x1; x2; a; b];

write('answer.txt',answer);
write('fillings.txt',fillings);
write('data.txt',[]);

//quit();




