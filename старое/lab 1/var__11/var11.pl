% --- Факты ---
dish(soup).                 % Блюдо — суп
dish(salad).                % Блюдо — салат

ingredient(soup, water).    % В супе используется вода
ingredient(soup, potato).   % В супе используется картофель
ingredient(salad, lettuce). % В салате используется салат-латук

chef(ivan).                 % Повар Иван
prepares(ivan, soup).       % Иван готовит суп

% --- Правила ---
can_prepare(Chef, Dish) :- prepares(Chef, Dish). % Повар может приготовить блюдо, если оно за ним закреплено
needs(Dish, Ing) :- ingredient(Dish, Ing).       % Блюдо требует ингредиент, если он для него указан
