function resizeUI(f, ax1, ax2, slider_gray, slider_contrast, filter_menu)
    fig_pos = get(f, 'Position');
    fig_width = fig_pos(3);
    fig_height = fig_pos(4);

    % Atualiza as posições dos elementos para centralização e responsividade
    set(ax1, 'Position', [0.1, 0.5, 0.35, 0.4]);
    set(ax2, 'Position', [0.55, 0.5, 0.35, 0.4]);

    % Calcula a largura total dos sliders e os centraliza
    slider_width_total = 2 * 300 + 30;  % Calcula a largura total para centralização
    set(slider_gray, 'Position', [(fig_width - slider_width_total) / 2, fig_height*0.4, 300, 20]);
    set(slider_contrast, 'Position', [(fig_width - slider_width_total) / 2 + 330, fig_height*0.4, 300, 20]);

    % Centraliza os textos dos sliders
    set(findobj(f, 'String', 'Escala de Cinza'), 'Position', [(fig_width - slider_width_total) / 2 + 100, fig_height*0.4 + 25, 100, 20]);
    set(findobj(f, 'String', 'Contraste'), 'Position', [(fig_width - slider_width_total) / 2 + 430, fig_height*0.4 + 25, 100, 20]);

    % Calcula e ajusta a posição dos campos de entrada do filtro passa-baixa e tipo de filtro
    total_width = 2 * 150 + 50;  % Calcula a largura total para centralização dos elementos do filtro passa-baixa
    set(findobj('Tag', 'input_param_lowpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_lowpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3 + 25, 150, 20]);

    set(findobj('Tag', 'popup_filter_type_lowpass'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_filter_type_lowpass'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3 + 25, 150, 20]);

    % Centraliza o botão "Aplicar Parâmetro" abaixo dos dois elementos
    set(findobj('Tag', 'apply_button_lowpass'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

    % Calcula e ajusta a posição dos campos de entrada do filtro passa-alta e tipo de filtro
    total_width = 2 * 150 + 50;  % Calcula a largura total para centralização dos elementos do filtro passa-alta
    set(findobj('Tag', 'input_param_highpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_highpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3 + 25, 150, 20]);

    set(findobj('Tag', 'popup_filter_type'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_filter_type'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3 + 25, 150, 20]);

    % Centraliza o botão "Aplicar Parâmetro" abaixo dos dois elementos
    set(findobj('Tag', 'apply_button'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

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

