% --- Факты ---
threat(phishing).               % Угроза — фишинг
threat(malware).                % Угроза — вредоносное ПО

targets(phishing, users).       % Фишинг направлен на пользователей
targets(malware, servers).      % Вредоносное ПО направлено на серверы

risk_high(malware).             % Угроза malware имеет высокий риск

% --- Правила ---
is_risky(T) :- threat(T), risk_high(T). % Угроза является опасной, если у неё высокий риск
affects(Target, Threat) :- targets(Threat, Target). % Угроза влияет на цель, если она её атакует
