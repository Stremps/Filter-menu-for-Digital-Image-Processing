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

    % Centraliza campos do filtro passa-baixa
    total_width = 2 * 150 + 50; 
    set(findobj('Tag', 'input_param_lowpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_lowpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'popup_filter_type_lowpass'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_filter_type_lowpass'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'apply_button_lowpass'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

    % Centraliza campos do filtro passa-alta
    set(findobj('Tag', 'input_param_highpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_highpass'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'popup_filter_type'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_filter_type'), 'Position', [(fig_width - total_width) / 2 + 150 + 50, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'apply_button'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

    % Centraliza campos do filtro de extração de borda
    set(findobj('Tag', 'popup_filter_type_edge'), 'Position', [(fig_width - 150) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_filter_type_edge'), 'Position', [(fig_width - 150) / 2, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'apply_button_edge'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

    % Centraliza campos do ruído
    total_width_noise = 2 * 150 + 50;  % Calcula a largura total para centralização
    set(findobj('Tag', 'popup_noise_type'), 'Position', [(fig_width - total_width_noise) / 2, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_noise_type'), 'Position', [(fig_width - total_width_noise) / 2, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'input_param_variance'), 'Position', [(fig_width - total_width_noise) / 2 + 150 + 50, fig_height*0.3, 150, 20]);
    set(findobj('Tag', 'label_param_variance'), 'Position', [(fig_width - total_width_noise) / 2 + 150 + 50, fig_height*0.3 + 25, 150, 20]);
    set(findobj('Tag', 'apply_button_noise'), 'Position', [(fig_width - 120) / 2, fig_height*0.3 - 40, 120, 30]);

    % Centraliza o slider do Watershed
    total_width_watershed = 300;
    set(findobj('Tag', 'slider_watershed_threshold'), 'Position', [(fig_width - total_width_watershed) / 2, fig_height*0.3, 300, 20]);
    set(findobj('Tag', 'label_watershed_threshold'), 'Position', [(fig_width - total_width_watershed) / 2, fig_height*0.3 + 25, 300, 20]);

    % Centraliza o slider de contagem de objetos
    total_width = 300;
    set(findobj('Tag', 'slider_object_threshold'), 'Position', [(fig_width - total_width) / 2, fig_height * 0.3, 300, 20]);
    set(findobj('Tag', 'label_object_threshold'), 'Position', [(fig_width - total_width) / 2, fig_height * 0.3 + 25, 300, 20]);

    % Centraliza o número de objetos
    set(findobj('Tag', 'text_object_count'), 'Position', [(fig_width - total_width) / 2, fig_height * 0.3 - 135, 300, 20]);

    % Centraliza a entrada de valor mínimo para o bwareaopen (abaixo do slider)
    set(findobj('Tag', 'input_min_area'), 'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 55, 100, 20]);
    set(findobj('Tag', 'label_min_area'), 'Position', [(fig_width - 200) / 2, fig_height * 0.3 - 30, 200, 20]);

    % Centraliza o botão "Aplicar Filtro"
    set(findobj('Tag', 'apply_buttonc'), 'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 95, 100, 30]);


    % Centraliza os controles da Limiarização
    total_width = 300; % Largura do slider de Limiarização
    set(findobj('Tag', 'slider_threshold'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3, 300, 20]);
    set(findobj('Tag', 'label_threshold'), 'Position', [(fig_width - total_width) / 2, fig_height*0.3 + 25, 300, 20]);

    % Centraliza o slider do Watershed
    total_width_watershed = 300; % Largura do slider de Watershed
    set(findobj('Tag', 'slider_watershed_threshold'), 'Position', [(fig_width - total_width_watershed) / 2, fig_height*0.3, 300, 20]);
    set(findobj('Tag', 'label_watershed_threshold'), 'Position', [(fig_width - total_width_watershed) / 2, fig_height*0.3 + 25, 300, 20]);

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
