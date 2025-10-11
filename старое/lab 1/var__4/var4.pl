% --- Факты ---
phase(analysis).                % Фаза анализа
phase(design).                  % Фаза проектирования
phase(implementation).          % Фаза реализации

task(t1, analysis).             % Задача T1 в фазе анализа
task(t2, design).               % Задача T2 в фазе проектирования
task(t3, implementation).       % Задача T3 в фазе реализации

depends(t2, t1).                % Задача T2 зависит от задачи T1
depends(t3, t2).                % Задача T3 зависит от задачи T2

assigned(t1, alice).            % Задача T1 назначена Алисе
assigned(t2, bob).              % Задача T2 назначена Бобу

% --- Правила ---
can_start(Task) :- not(depends(Task,_)).          % Задача может начаться, если от неё не зависят другие
ready(Task) :- depends(Task, Dep), finished(Dep). % Задача готова, если выполнены зависимости
