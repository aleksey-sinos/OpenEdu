%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 6.
%% Использование байесовского подхода при
%% различных значениях априорной неопределенности
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

%% Моделирование измерений %%
%априорное математическое ожидание
x_exp = 1e2*randn;

%дисперсия априорной оценки
sn = 5; %количество вариантов
x_var_max = rand*3;
x_var_min = -3;
x_var = logspace(x_var_min,x_var_max,sn);

%истинное значение величины
x_true = 3.14;

%количество измерений
mn = 100;

%Дисперсия измерений
m_var = 10;

%Моделирование
x_m = x_true+sqrt(m_var)*randn(1,mn);

x_est = zeros(sn,mn);
%% Оценивание %%
for j=1:sn
for i=1:mn
x_est(j,i) = (x_exp+(x_var(j)/(x_var(j)+(1/i)*m_var))*(sum(x_m(1:i)-x_exp))/i);
end
end
    
%% Графики %%

figure(1); clf;
hold on; grid;
plot(x_m,'*','DisplayName','measurements');
for i = 1:sn
plot(1:mn,x_est(i,:),'DisplayName',['var =' num2str(x_var(i))]);
end
plot(x_exp,'or','DisplayName','x exp');
legend(gca,'show');
