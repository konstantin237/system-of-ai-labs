% --- Факты ---
is(crm).                  % CRM — это информационная система
is(erp).                  % ERP — это информационная система

user(alice).              % Алиса — пользователь
user(bob).                % Боб — пользователь

stores(crm, customers_data). % CRM хранит данные о клиентах
processes(erp, accounting).  % ERP обрабатывает бухгалтерию

access(alice, crm).       % Алиса имеет доступ к CRM
access(bob, erp).         % Боб имеет доступ к ERP

% --- Правила ---
user_can_read(User, Data) :- access(User, IS), stores(IS, Data). % Пользователь может читать данные, если имеет доступ к системе, которая их хранит
system_processes(IS, What) :- processes(IS, What).               % Система выполняет обработку данных, если это указано в её процессах
