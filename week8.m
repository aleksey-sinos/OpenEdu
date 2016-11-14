%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Неделя 8.
%% Формирующий фильтр.
%% Моделирование динамики матрицы ковариаций в байесовском подходе.
%% Рекуррентный  метод.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%% Параметры  %%

mn = 100; %Количество измерений

%% 1 - скалярный %%
%% 2 - векторный %%
var = 2; 

if var==1
    %% Скалярный случай %%
    x_0 = 0;
    P_0 = 0;
    F = 1;
    G = 1;

    x = zeros(1,mn); x(1) = x_0;
    x_ex = zeros(5,mn); x_ex(1,:) = x_0;
    P = zeros(1,mn); P(1) = P_0;

    for i = 2:mn
        x(i) = F*x(i-1);
        P(i) = F*P(i-1)*F'+G*G';
    end

    for j = 1:5
        for i = 2:mn
           x_ex(j,i) =x_ex(j,i-1)+randn;
        end
    end

    figure(1); clf;
    title('Динамика математического ожидания и СКО')
    hold on; grid;
    h(1) = plot(1:mn,x,'b');
    h(2) = plot(1:mn,3*sqrt(P),'r');
    plot(1:mn,-3*sqrt(P),'r');
    for j = 1:5
        h(3) = plot(1:mn,x_ex(j,:),'g');
    end
    legend(h(:),'Математическое ожидание','3\sigma','Примеры возможных реализаций');
    disp(find(3*sqrt(P)>10,1));
    
end

if var == 2
    %% Векторный случай %%
    dt = 1;
    x_0 = [1000;5];
    P_0 = [100 0;
            0 0.1];
    F = [1 dt;
         0 1];
    G = [0 0;0 0.5];

    Q = eye(2);

    x = zeros(2,mn); x(:,1) = x_0;
    x_ex = zeros(2,mn,5); 
    P = zeros(2,2,mn); P(:,:,1) = P_0;

    for i = 2:mn
        x(:,i) = F*x(:,i-1);
        P(:,:,i) = F*P(:,:,i-1)*F'+G*Q*G';
    end

    for j = 1:5
        x_ex(:,1,j) = x_0+sqrt(P_0)*randn(2,1);
        for i = 2:mn
           x_ex(:,i,j) =F*x_ex(:,i-1,j)+G*randn(2,1);
        end
    end

    figure(1); clf;
    subplot(2,1,2);
    title('Динамика и СКО высоты')
    hold on; grid;
    h(1) = plot(1:mn,x(1,:),'b');
    h(2) = plot(1:mn,3*sqrt(squeeze(P(1,1,:)))+x(1,:)','r');
    plot(1:mn,-3*sqrt(squeeze(P(1,1,:)))+x(1,:)','r');
    for j = 1:5
        h(3) = plot(1:mn,x_ex(1,:,j),'g');
    end
    legend(h(:),'Математическое ожидание','3\sigma','Примеры возможных реализаций');
    %legend('Математическое ожидание','3\sigma');

    subplot(2,1,1);
    title('Динамика и СКО вертикальной скорости')
    hold on; grid;
    h(1) = plot(1:mn,x(2,:),'b');
    h(2) = plot(1:mn,3*sqrt(squeeze(P(2,2,:)))+x(2,:)','r');
    plot(1:mn,-3*sqrt(squeeze(P(2,2,:)))+x(2,:)','r');
    for j = 1:5
        h(3) = plot(1:mn,x_ex(2,:,j),'g');
    end
    legend(h(:),'Математическое ожидание','3\sigma','Примеры возможных реализаций');
    disp(3*sqrt(P(1,1,end)));

end
