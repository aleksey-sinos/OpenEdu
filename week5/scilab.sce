//////////////////////////////////////////////////////
// Неделя 5
// Оценивание с использованием метода максимума функции правдоподобия
//////////////////////////////////////////////////////

clear; 
rand("seed",getdate("s")); grand("setsd",getdate("s"));

// Моделирование измерений //
//количество измерений
mn=100;
//истинное значение величины
x_true=grand(1,1,"nor", 0, 10);

v=grand(1,mn,"unf", -5, 5)/10; //случайные величны с равномерным распределением (-0,5  0,5)
 
y=x_true*ones(1,mn)+v;
////////////////////////////////////////

//Выделение памяти
x_ma=zeros(1,mn);                                   
      

// Оценивание //
for i=1:mn
x_ma(i)= (1/i)*sum(y(1:i)); //Среднее арифметическое (для сравнения)
x_MLE_Up(i)=min(y(1:i))+0.5;
x_MLE_Down(i)=max(y(1:i))-0.5;
end

// Запись данных //
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
data = y';
answer = x_MLE_Up(mn);
write('data.txt',data);
write('answer.txt',answer);
write('fillings.txt',[]);

quit();


