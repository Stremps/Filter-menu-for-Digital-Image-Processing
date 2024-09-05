function resizeUI(f, ax1, ax2, slider_gray, slider_contrast, filter_menu)
    fig_pos = get(f, 'Position');
    fig_width = fig_pos(3);
    fig_height = fig_pos(4);

    % Atualiza as posições dos elementos para centralização e responsividade
    set(ax1, 'Position', [0.1, 0.5, 0.35, 0.4]);
    set(ax2, 'Position', [0.55, 0.5, 0.35, 0.4]);

    % Posiciona os sliders centralizados
    slider_width_total = 2 * 300 + 30;  % Calcula a largura total para centralização
    set(slider_gray, 'Position', [(fig_width - slider_width_total) / 2, fig_height*0.4, 300, 20]);
    set(slider_contrast, 'Position', [(fig_width - slider_width_total) / 2 + 330, fig_height*0.4, 300, 20]);

    % Centraliza os textos dos sliders
    set(findobj(f, 'String', 'Escala de Cinza'), 'Position', [(fig_width - slider_width_total) / 2 + 100, fig_height*0.4 + 25, 100, 20]);
    set(findobj(f, 'String', 'Contraste'), 'Position', [(fig_width - slider_width_total) / 2 + 430, fig_height*0.4 + 25, 100, 20]);

    % Centraliza o menu de filtros entre os botões
    button_width = 150;
    button_height = 40;
    spacing = 30; % Espaço entre os botões e o menu
    total_width = 3 * button_width + 2 * spacing;
    set(filter_menu, 'Position', [(fig_width - total_width) / 2 + button_width + spacing, 50, button_width, button_height]);

    % Atualiza as posições dos botões de carregar e salvar imagem
    set(findobj(f, 'String', 'Carregar Imagem'), 'Position', [(fig_width - total_width) / 2, 50, button_width, button_height]);
    set(findobj(f, 'String', 'Salvar Imagem'), 'Position', [(fig_width - total_width) / 2 + 2 * (button_width + spacing), 50, button_width, button_height]);
end
