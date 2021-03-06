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

// Графики //

figure(1); clf;
plot(1:mn,y,'b.',1:mn,x_true*ones(1,mn),...
    'r',1:mn,x_ma,1:mn,x_MLE_Up','g',1:mn,x_MLE_Down','g');
set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
legend('Измерения','Истинное значение','Среднее арифметическое','границы оценки МФП');
title('Оценивание по методу максимума функции правдоподобия');

mprintf('Истинное значние %f \n',x_true);
mprintf('Оценка сверху: %f снизу: %f \n',x_MLE_Up(mn),x_MLE_Down(mn));



// Запись данных //
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');
data = y';
answer = x_MLE_Up(mn);
write('data.txt',data);
write('answer.txt',answer);
write('fillings.txt',[]);


