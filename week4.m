%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 4.
%% Оценивание константы обобщенным методом наименьших квадратов
%% при наличии двух измерителей с различной дисперсией.
%% Количество измерений для датчиков одинаково.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear;

%% Моделирование измерений %%
%истинное значение величины
x = round(randn*100,2);

%количество измерений
mn = 100;

%Дисперсия измерителей
s1_var = 1;
s2_var = 27;

%Моделирование
s1_m = x+sqrt(s1_var)*randn(1,mn);
s2_m = x+sqrt(s2_var)*randn(1,mn);

x_est = zeros(1,mn);
%% Оценивание %%
for i=1:mn
x_est(i) = ((s2_var/(s1_var+s2_var))/i)*sum(s1_m(1:i))+...
        ((s1_var/(s1_var+s2_var))/i)*sum(s2_m(1:i));
end

%% Графики %%
if sh_plot == 1
    figure(1); clf;
    hold on; grid;
    plot(s1_m,'g*');
    plot(s2_m,'b.');
    plot(1:mn,x_est,'r','linewidth',2);
    legend('sensor 1','sensor 2','estimate')
end

%% Запись данных %%
if wr_data == 1
    s_data = [s1_m',s2_m'];
    %dlmwrite('s_data.txt',s_data, ',')
    save s_data.txt s_data -ASCII
end


