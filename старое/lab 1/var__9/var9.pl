% --- Факты ---
pc(pc1).                % Компьютер PC1
pc(pc2).                % Компьютер PC2

client(petro).          % Клиент Пётр

open_hours('10:00-22:00'). % Кафе открыто с 10 до 22

rate(per_hour, 100).    % Стоимость — 100 рублей за час

uses(petro, pc1).       % Пётр использует компьютер PC1

% --- Правила ---
can_use(Client, PC) :- client(Client), pc(PC). % Любой клиент может использовать компьютер
cost(Hours, Cost) :- rate(per_hour, R), Cost is Hours * R. % Стоимость = часы * тариф
