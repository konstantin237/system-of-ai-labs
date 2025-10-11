% --- Факты ---
tool(firewall).              % Средство безопасности — firewall
tool(antivirus).             % Средство безопасности — антивирус

protects(firewall, network). % Firewall защищает сеть
protects(antivirus, workstation). % Антивирус защищает рабочие станции

resource(network).           % Сеть — ресурс
resource(workstation).       % Рабочая станция — ресурс

% --- Правила ---
is_protected(Resource) :- protects(Tool, Resource), tool(Tool). % Ресурс защищён, если его защищает средство
