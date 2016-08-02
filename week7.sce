//////////////////////////////////////////////////////
// Неделя 7.
// Комплексная обработка двух измерителей с использованием байесовского подхода.
// Исследование точности с помощью матрицы ковариаций.
// Нерекурсивный метод.
//////////////////////////////////////////////////////

// Параметры  //

mn = 100; //Количество измерений

sigma_h0 = 10; //Начальная дисперсия оценки высоты
sigma_v = 5; //Начальная дисперсия оценки скорости

//Дисперсия измерителей
SNS_var = 2;
BAR_var = 5;

P_x = [sigma_h0 0;...
        0 sigma_v]; //Начальная матрица ковариаций х
P = zeros(2,2,mn);
P_ba = zeros(2,2,mn);
for i = 1:mn
R_sns = eye(i)*SNS_var; //Матрица ковариаций снс

R_ba = eye(i)*BAR_var; //Матрица ковариаций баровысотомера

// Расчет матрицы ковариаций //

//Матрица наблюдения
H = ones(i,2); 
H(:,2) = [0:i-1]';

P(:,:,i) = (P_x^-1 + H'*R_sns^-2*H+H'*R_ba^-1*H)^-1; //Матрица ковариаций для всего набора измерений
P_ba(:,:,i) = (P_x^-1 + H'*R_ba^-1*H)^-1; //Матрица ковариаций при отсутствии измерений GPS
end
h_f_sko = squeeze(sqrt(P(1,1,1:mn)));
v_f_sko = squeeze(sqrt(P(2,2,1:mn)));

h_b_sko = squeeze(sqrt(P_ba(1,1,1:mn)));
v_b_sko = squeeze(sqrt(P_ba(2,2,1:mn)));

figure(1); clf;
set(gca(),"auto_clear","off"); set(gca(),"grid",[1 1]);
plot(1:mn,3*h_f_sko','b',1:mn,-3*h_f_sko','b');
plot(1:mn,3*h_b_sko','r',1:mn,-3*h_b_sko','r');

figure(2); clf;
set(gca(),"auto_clear","off"); set(gca(),"grid",[1 1]);
plot(1:mn,3*v_f_sko','b',1:mn,-3*v_f_sko','b');
plot(1:mn,3*v_b_sko','r',1:mn,-3*v_b_sko','r');

mtlb_fprintf('Матрица ковариаций ошибок оцениивания после %g измерений: \n',mn);
disp(P(:,:,mn));

mtlb_fprintf('3 сигма высоты после %g измерений: %g \n',mn,h_f_sko(mn));
mtlb_fprintf('3 сигма вертикальной скорости с СНС после %g измерений: %g \n',mn, v_f_sko(mn));
mtlb_fprintf('3 сигма вертикальной скорости без СНС после %g измерений: %g \n',mn, v_b_sko(mn));






