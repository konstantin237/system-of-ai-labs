% --- Факты ---
client(anna).             % Клиент Анна

tour(paris).              % Тур в Париж
tour(sochi).              % Тур в Сочи

booked(anna, sochi).      % Анна забронировала тур в Сочи

destination(paris, france). % Париж — во Франции
destination(sochi, russia). % Сочи — в России

% --- Правила ---
client_has_booking(C) :- booked(C, _).             % Клиент имеет бронь, если есть факт бронирования
tour_to_country(Tour, Country) :- destination(Tour, Country). % Тур относится к стране, если указано направление
