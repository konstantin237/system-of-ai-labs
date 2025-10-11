% --- Факты ---
os(linux).          % Linux — это операционная система
os(windows).        % Windows — это операционная система

process(shell).     % Shell — это процесс
process(app1).      % App1 — это процесс

runs(linux, shell). % Linux запускает процесс Shell
runs(linux, app1).  % Linux запускает процесс App1
driver(linux, disk).% Linux поддерживает устройство диск
driver(windows, gpu). % Windows поддерживает видеокарту

device(disk).       % Диск — это устройство
device(gpu).        % Видеокарта — это устройство

% --- Правила ---
os_has_process(OS, P) :- runs(OS, P).            % ОС имеет процесс, если она его запускает
os_supports_device(OS, D) :- driver(OS, D), device(D). % ОС поддерживает устройство, если есть драйвер
