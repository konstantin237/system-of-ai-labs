% --- Факты ---
dept(sales).             % Отдел продаж
dept(it).                % IT-отдел

employee(ivan).          % Иван — сотрудник
employee(maria).         % Мария — сотрудник

works_in(ivan, sales).   % Иван работает в отделе продаж
works_in(maria, it).     % Мария работает в IT-отделе

project(project_alpha).  % Существует проект Alpha
manages(maria, project_alpha). % Мария руководит проектом Alpha

% --- Правила ---
employee_in_project(Emp, Project) :- works_in(Emp, Dept), dept_has_project(Dept, Project). % Сотрудник участвует в проекте, если его отдел участвует
dept_has_project(it, project_alpha). % IT-отдел участвует в проекте Alpha
