%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 6.
%% Использование байесовского подхода при
%% различных значениях априорной неопределенности
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;

%% Моделирование измерений %%
%истинное значение величины
x_true = 10;                        %Для заполнения
%априорное математическое ожидание
x_exp = 3*sign(randn)*x_true+round(4*randn); %Для заполнения

%дисперсия априорной оценки
sn = 5; %количество вариантов
x_var_max = 2;                      %Для заполнения 100
x_var_min = -3;                     %Для заполнения 0.001
x_var = logspace(x_var_min,x_var_max,sn);


%количество измерений
mn = 100;

%Дисперсия измерений
m_var = 10+randn;                         %Для заполнения

%Моделирование
y = x_true+sqrt(m_var)*randn(1,mn);

x_est = zeros(sn,mn);
%% Оценивание %%
for j=1:sn
for i=1:mn
x_est(j,i) = x_exp+(x_var(j)/(x_var(j)+(1/i)*m_var))*(sum(y(1:i)-x_exp))/i;
end
end
    
%% Графики %%
figure(1); clf;
hold on; grid;
plot(y,'*','DisplayName','y');
for i = 1:sn
plot(1:mn,x_est(i,:),'DisplayName',['$\sigma^2_0$ = ' num2str(x_var(i))]);
end
plot(x_exp,'or','DisplayName','$\widehat{x}_0$');
I = legend(gca,'show');
set(I,'interpreter','latex');


fprintf('Оценка при sigma^2_0 = 0.001: %.3f \n',x_est(1,end));
fprintf('Оценка при sigma^2_0 = 100: %.3f \n',x_est(sn,end));

%% Запись данных %%
data = y';
answer = [x_est(1,end)'; x_est(sn,end)'];
fillings = [x_exp; m_var];

save('data6.txt','data','-ascii');
save('answer6.txt','answer','-ascii');
save('fillings6.txt','fillings','-ascii');

