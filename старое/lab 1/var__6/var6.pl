% --- Факты ---
student(oleg).            % Олег — студент
student(nina).            % Нина — студентка

course(math).             % Курс математики
course(programming).      % Курс программирования

lecturer(prof_sidorov).   % Преподаватель — профессор Сидоров
teaches(prof_sidorov, programming). % Профессор Сидоров ведёт курс программирования

enrolled(oleg, programming). % Олег записан на курс программирования
enrolled(nina, math).        % Нина записана на курс математики

% --- Правила ---
student_has_lecturer(S, L) :- enrolled(S, C), teaches(L, C). % У студента есть преподаватель, если он записан на его курс
