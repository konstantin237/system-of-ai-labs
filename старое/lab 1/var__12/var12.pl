% --- Факты ---
room(r101).              % Номер r101
room(r102).              % Номер r102

client(sergey).          % Клиент Сергей

booked(sergey, r101).    % Сергей забронировал номер r101

% --- Правила ---
is_booked(Room) :- booked(_, Room).               % Номер забронирован, если кто-то его занял
free_room(Room) :- room(Room), \+ is_booked(Room).% Номер свободен, если он существует и не забронирован
