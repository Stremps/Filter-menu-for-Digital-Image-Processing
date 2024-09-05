function custom_interface_v2()
  % Carregar o pacote de imagem
  pkg load image;

  % Dimensões do monitor para centralização
  screen_width = 1920;
  screen_height = 1080;

  % Cria uma nova janela (figure) com centralização de acordo com a resolução do monitor
  fig_width = 900;
  fig_height = 600;
  f = figure('Position', [(screen_width - fig_width) / 2, (screen_height - fig_height) / 2, fig_width, fig_height], ...
             'Name', 'Processamento de Imagens', 'NumberTitle', 'off', 'Resize', 'on');

  % Eixo para exibição da imagem original
  ax1 = axes('Parent', f, 'Position', [0.1, 0.5, 0.35, 0.4]);
  title(ax1, 'Imagem Original');

  % Eixo para exibição da imagem modificada
  ax2 = axes('Parent', f, 'Position', [0.55, 0.5, 0.35, 0.4]);
  title(ax2, 'Imagem Modificada');

  % Largura total dos sliders
  slider_width_total = 2 * 300 + 30;  % Largura total para centralizar os sliders

  % Slider para escala de cinza (centralizado)
  slider_gray = uicontrol('Style', 'slider', 'Min', 0, 'Max', 100, 'Value', 50, ...
                    'Position', [(fig_width - slider_width_total) / 2, 250, 300, 20], ...
                    'Tag', 'slider_gray', ...
                    'Visible', 'off', ...  % Inicialmente oculto
                    'Callback', @(src, event) grey_function(src, ax1, ax2));
  uicontrol('Style', 'text', 'String', 'Escala de Cinza', 'Position', [(fig_width - slider_width_total) / 2 + 100, 275, 100, 20], 'HorizontalAlignment', 'center', 'Tag', 'label_gray', 'Visible', 'off');

  % Slider para contraste (centralizado)
  slider_contrast = uicontrol('Style', 'slider', 'Min', -100, 'Max', 100, 'Value', 0, ...
                    'Position', [(fig_width - slider_width_total) / 2 + 330, 250, 300, 20], ...
                    'Tag', 'slider_contrast', ...
                    'Visible', 'off', ...  % Inicialmente oculto
                    'Callback', @(src, event) grey_function(src, ax1, ax2));
  uicontrol('Style', 'text', 'String', 'Contraste', 'Position', [(fig_width - slider_width_total) / 2 + 430, 275, 100, 20], 'HorizontalAlignment', 'center', 'Tag', 'label_contrast', 'Visible', 'off');

  % Elemento de entrada de parâmetro para filtro passa-alta (centralizado e responsivo)
  input_param_highpass = uicontrol('Style', 'edit', 'String', '0.2', ...
                                   'Position', [(fig_width - 100) / 2, 200, 100, 20], ...
                                   'Tag', 'input_param_highpass', ...
                                   'Visible', 'off');  % Inicialmente oculto
  uicontrol('Style', 'text', 'String', 'Parâmetro Passa-Alta', ...
            'Position', [(fig_width - 150) / 2, 225, 150, 20], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_highpass', 'Visible', 'off');

  % Botão para aplicar o parâmetro do filtro passa-alta (centralizado e abaixo do campo de entrada)
  apply_button = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Parâmetro', ...
                           'Position', [(fig_width - 120) / 2, 160, 120, 30], ...
                           'Tag', 'apply_button', ...
                           'Visible', 'off', ...  % Inicialmente oculto
                           'Callback', @(src, event) apply_highpass_filter(ax2));

  % Botão para carregar imagem (centralizado)
  button_width = 150;
  button_height = 40;
  spacing = 30; % Espaço entre os botões e o menu
  total_width = 3 * button_width + 2 * spacing;
  
  uicontrol('Style', 'pushbutton', 'String', 'Carregar Imagem', ...
            'Position', [(fig_width - total_width) / 2, 50, button_width, button_height], ...
            'Callback', @(src, event) image_operations('load', ax1, ax2));

  % Menu suspenso para seleção de filtros (centralizado entre os botões)
  filter_menu = uicontrol('Style', 'popupmenu', 'String', {'Selecionar Filtro', 'Escala de Cinza', 'Filtro Passa-Alta'}, ...
                          'Position', [(fig_width - total_width) / 2 + button_width + spacing, 50, button_width, button_height], ...
                          'Callback', @(src, event) apply_filter(get(src, 'Value'), ax1, ax2));

  % Botão para salvar imagem modificada (centralizado)
  uicontrol('Style', 'pushbutton', 'String', 'Salvar Imagem', ...
            'Position', [(fig_width - total_width) / 2 + 2 * (button_width + spacing), 50, button_width, button_height], ...
            'Callback', @(src, event) image_operations('save'));

  % Ajusta o tamanho e a posição dos elementos da interface para torná-los responsivos
  set(f, 'SizeChangedFcn', @(src, event) resizeUI(f, ax1, ax2, slider_gray, slider_contrast, filter_menu));

  % Espera até que a janela seja fechada
  uiwait(f);
end

% Função para aplicar o filtro selecionado
function apply_filter(filter_index, ax1, ax2)
    % Ocultar todos os controles inicialmente
    set(findobj('Tag', 'slider_gray'), 'Visible', 'off');
    set(findobj('Tag', 'label_gray'), 'Visible', 'off');
    set(findobj('Tag', 'slider_contrast'), 'Visible', 'off');
    set(findobj('Tag', 'label_contrast'), 'Visible', 'off');
    set(findobj('Tag', 'input_param_highpass'), 'Visible', 'off');
    set(findobj('Tag', 'label_highpass'), 'Visible', 'off');
    set(findobj('Tag', 'apply_button'), 'Visible', 'off');

    img = evalin('base', 'img');
    if isempty(img)
        errordlg('Carregue uma imagem primeiro!', 'Erro');
        return;
    end
    
    switch filter_index
        case 2  % Escala de Cinza
            set(findobj('Tag', 'slider_gray'), 'Visible', 'on');
            set(findobj('Tag', 'label_gray'), 'Visible', 'on');
            set(findobj('Tag', 'slider_contrast'), 'Visible', 'on');
            set(findobj('Tag', 'label_contrast'), 'Visible', 'on');
            grey_function([], ax1, ax2);

        case 3  % Filtro Passa-Alta
            set(findobj('Tag', 'input_param_highpass'), 'Visible', 'on');
            set(findobj('Tag', 'label_highpass'), 'Visible', 'on');
            set(findobj('Tag', 'apply_button'), 'Visible', 'on');
            apply_highpass_filter(ax2); % Aplica automaticamente o filtro com o valor padrão exibido
    end
end

% Função para aplicar o filtro passa-alta com o parâmetro atual
function apply_highpass_filter(ax2)
    img = evalin('base', 'img');
    if isempty(img)
        errordlg('Carregue uma imagem primeiro!', 'Erro');
        return;
    end

    param_value = str2double(get(findobj('Tag', 'input_param_highpass'), 'String'));
    if isnan(param_value)
        errordlg('Insira um valor numérico válido para o parâmetro do filtro passa-alta!', 'Erro');
        return;
    end

    img_filtered = pass_filters('high_pass', img, param_value);  % Chama o filtro passa-alta com o parâmetro ajustável
    assignin('base', 'img_modified', img_filtered);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_filtered);
end
