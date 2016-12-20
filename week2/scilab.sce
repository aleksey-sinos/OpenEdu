//////////////////////////////////////////////////////////////////////////////////////////////////////
//// Неделя 2.
//// Моделирование случайных величин и векторов в Scilab.
//////////////////////////////////////////////////////////////////////////////////////////////////////
clear; deff('[numd] = roundd(num,n)','numd = round(num *10^n) / 10^n');

//// Моделирование случайной величины ////
grand("setsd",getdate("s"))
//количество измерений
len = 10000;
noc = 100;
m_1 = (rand()-0.5)*3;
m_2 = (rand()+0.5)*4;
x_1 = grand(len,1,"nor", m_1, 1);
x_2 = grand(len,1,"nor", m_2, 1.5);
rvect = [x_1; x_2];

m_rvect = mean(rvect);
var_rvect = variance(rvect);
mprintf('Математическое ожидание: %f \n',m_rvect);
mprintf('Дисперсия: %f \n',var_rvect);
[cf, ind] = histc(noc,rvect,normalization=%t); [m,k] = max(cf);
mp_rvect = ((max(rvect)-min(rvect))/noc*(k-0.5))+min(rvect);
mprintf('Argmax выборочной функции плотности распределения: %f \n',mp_rvect);
// Графики //
    figure(1); clf;
    set(gca(),"auto_clear","off"); xgrid(1,0.1,10);
	histplot(noc,[x_1; x_2]);
	plot(mp_rvect,m,'r*');
    //legend('Измерения датчика 1','Измерения датчика 2','Оценка');
    title('Гистограмма случайной величины');

//// Запись данных //// 
deletefile('data.txt'); deletefile('fillings.txt'); deletefile('answer.txt');

write('data.txt', rvect);
write('answer.txt', [m_rvect; var_rvect; mp_rvect])
write('fillings.txt', []);

//quit();



