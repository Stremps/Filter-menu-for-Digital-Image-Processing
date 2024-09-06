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

    % Define as larguras dos elementos e espaçamento
    element_width = 150;
    element_height = 20;
    button_height = 30;
    spacing_between_elements = 30; % Ajuste o espaçamento para centralizar

    % Calcula a posição de centralização com base na largura total da figura e dos elementos
    total_width = 2 * element_width + spacing_between_elements; % Largura total necessária para centralização
    center_x = (fig_width - total_width) / 2; % Posição inicial no eixo x para centralização

    % Campo de entrada para parâmetro passa-baixa
    input_param_lowpass = uicontrol('Style', 'edit', 'String', '3', ...
                                    'Position', [center_x, 200, element_width, element_height], ...
                                    'Tag', 'input_param_lowpass', ...
                                    'Visible', 'off');

    % Texto para o campo de entrada (acima do campo)
    uicontrol('Style', 'text', 'String', 'Parâmetro Passa-Baixa', ...
            'Position', [center_x, 225, element_width, element_height], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_lowpass', 'Visible', 'off');

    % Menu suspenso para escolher tipo de filtro passa-baixa
    popup_filter_type_lowpass = uicontrol('Style', 'popupmenu', 'String', {'média', 'mediana'}, ...
                                        'Position', [center_x + element_width + spacing_between_elements, 200, element_width, element_height], ...
                                        'Tag', 'popup_filter_type_lowpass', ...
                                        'Visible', 'off');

    % Texto para o menu suspenso (acima do menu)
    uicontrol('Style', 'text', 'String', 'Tipo de Filtro', ...
            'Position', [center_x + element_width + spacing_between_elements, 225, element_width, element_height], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_filter_type_lowpass', 'Visible', 'off');

    % Botão para aplicar o parâmetro do filtro passa-baixa (abaixo e centralizado entre os dois elementos)
    apply_button_lowpass = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Parâmetro', ...
                                    'Position', [center_x + (total_width - element_width) / 2, 160, element_width, button_height], ...
                                    'Tag', 'apply_button_lowpass', ...
                                    'Visible', 'off', ...
                                    'Callback', @(src, event) apply_lowpass_filter(ax2));

    % Ajuste similar para o filtro Passa-Alta
    input_param_highpass = uicontrol('Style', 'edit', 'String', '0', ...
                                    'Position', [center_x, 200, element_width, element_height], ...
                                    'Tag', 'input_param_highpass', ...
                                    'Visible', 'off');

    uicontrol('Style', 'text', 'String', 'Parâmetro Passa-Alta', ...
            'Position', [center_x, 225, element_width, element_height], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_highpass', 'Visible', 'off');

    popup_filter_type = uicontrol('Style', 'popupmenu', 'String', {'básico', 'alto reforço'}, ...
                                'Position', [center_x + element_width + spacing_between_elements, 200, element_width, element_height], ...
                                'Tag', 'popup_filter_type', ...
                                'Visible', 'off');

    uicontrol('Style', 'text', 'String', 'Tipo de Filtro', ...
            'Position', [center_x + element_width + spacing_between_elements, 225, element_width, element_height], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_filter_type', 'Visible', 'off');

    apply_button = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Parâmetro', ...
                            'Position', [center_x + (total_width - element_width) / 2, 160, element_width, button_height], ...
                            'Tag', 'apply_button', ...
                            'Visible', 'off', ...
                            'Callback', @(src, event) apply_highpass_filter(ax2));
    
    

    % Botão para carregar imagem (centralizado)
    button_width = 150;
    button_height = 40;
    spacing = 30; % Espaço entre os botões e o menu
    total_width = 3 * button_width + 2 * spacing;
    
    uicontrol('Style', 'pushbutton', 'String', 'Carregar Imagem', ...
                'Position', [(fig_width - total_width) / 2, 50, button_width, button_height], ...
                'Callback', @(src, event) image_operations('load', ax1, ax2));

    % Menu flutante de filtros
    filter_menu = uicontrol('Style', 'popupmenu', 'String', {'Selecionar Filtro', 'Escala de Cinza', 'Filtro Passa-Alta', 'Filtro Passa-Baixa', 'Extração de Borda', 'Ruidos', 'Limiarização', 'Histograma (Escala de Cinza)', 'Watershed', 'Contagem de Objetos'}, ...
                        'Position', [(fig_width - total_width) / 2 + button_width + spacing, 50, button_width, button_height], ...
                        'Callback', @(src, event) apply_filter(get(src, 'Value'), ax1, ax2));




    % Adicionar um slider para o valor do limiar (Threshold)
    slider_threshold = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0.5, ...
                        'Position', [(fig_width - 300) / 2, fig_height*0.3, 300, 20], ...
                        'Tag', 'slider_threshold', ...
                        'Visible', 'off', ...  % Inicialmente oculto
                        'Callback', @(src, event) apply_threshold_filter(ax1, ax2));

    uicontrol('Style', 'text', 'String', 'Valor de Limiar', 'Position', [(fig_width - 100) / 2, fig_height*0.3 + 25, 100, 20], 'HorizontalAlignment', 'center', 'Tag', 'label_threshold', 'Visible', 'off');


    % Atualize o Popup de Seleção de Filtro para Extração de Borda
    popup_filter_type_edge = uicontrol('Style', 'popupmenu', 'String', {'roberts', 'prewitt', 'sobel', 'zerocross', 'log', 'canny'}, ...
                                    'Position', [(fig_width - 150) / 2, 250, 150, 30], ...
                                    'Tag', 'popup_filter_type_edge', ...
                                    'Visible', 'off');  % Inicialmente oculto
    uicontrol('Style', 'text', 'String', 'Tipo de Filtro', ...
            'Position', [(fig_width - 150) / 2, 280, 150, 20], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_filter_type_edge', 'Visible', 'off');


    % Botão para aplicar o filtro (abaixo do menu)
    apply_button_edge = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Filtro', ...
                                'Position', [(fig_width - 150) / 2, 200, 150, 30], ...
                                'Tag', 'apply_button_edge', ...
                                'Visible', 'off', ...
                                'Callback', @(src, event) apply_edge_filter(ax2));  % Função de callback para aplicar o filtro



    % Botão para salvar imagem modificada (centralizado)
    uicontrol('Style', 'pushbutton', 'String', 'Salvar Imagem', ...
                'Position', [(fig_width - total_width) / 2 + 2 * (button_width + spacing), 50, button_width, button_height], ...
                'Callback', @(src, event) image_operations('save'));

    % Ajusta o tamanho e a posição dos elementos da interface para torná-los responsivos
    set(f, 'SizeChangedFcn', @(src, event) resizeUI(f, ax1, ax2, slider_gray, slider_contrast, filter_menu));

    % Menu suspenso para escolher tipo de ruído
    popup_noise_type = uicontrol('Style', 'popupmenu', 'String', {'Salt & Pepper', 'Gaussian', 'Speckle', 'Poisson'}, ...
                                'Position', [(fig_width - 150) / 2, 250, 150, 30], ...
                                'Tag', 'popup_noise_type', ...
                                'Visible', 'off');  % Inicialmente oculto
    uicontrol('Style', 'text', 'String', 'Tipo de Ruído', ...
            'Position', [(fig_width - 150) / 2, 280, 150, 20], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_noise_type', 'Visible', 'off');

    % Parâmetros para variância e intensidade (exemplo)
    input_param_variance = uicontrol('Style', 'edit', 'String', '0.02', ...
                                    'Position', [(fig_width - 150) / 2, 220, 150, 20], ...
                                    'Tag', 'input_param_variance', ...
                                    'Visible', 'off');
    uicontrol('Style', 'text', 'String', 'Variância', ...
            'Position', [(fig_width - 150) / 2, 245, 150, 20], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_param_variance', 'Visible', 'off');

    % Botão para aplicar o ruído
    apply_button_noise = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Ruído', ...
                                'Position', [(fig_width - 150) / 2, 180, 150, 30], ...
                                'Tag', 'apply_button_noise', ...
                                'Visible', 'off', ...
                                'Callback', @(src, event) apply_noise(ax2));

    % Adicionar um slider para o valor do limiar (Threshold) para Watershed
    slider_watershed_threshold = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0.5, ...
                            'Position', [(fig_width - 300) / 2, fig_height*0.3, 300, 20], ...
                            'Tag', 'slider_watershed_threshold', ...
                            'Visible', 'off', ...  % Inicialmente oculto
                            'Callback', @(src, event) apply_watershed_filter(ax1, ax2, src));

    uicontrol('Style', 'text', 'String', 'Valor de Limiar (Watershed)', 'Position', [(fig_width - 100) / 2, fig_height*0.3 + 25, 100, 20], ...
            'HorizontalAlignment', 'center', 'Tag', 'label_watershed_threshold', 'Visible', 'off');

    % Adicionando o slider de threshold para a Contagem de Objetos
    slider_object_threshold = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0.5, ...
                                        'Position', [(fig_width - 300) / 2, fig_height * 0.3, 300, 20], ...
                                        'Tag', 'slider_object_threshold', ...
                                        'Visible', 'off', ...  % Inicialmente oculto
                                        'Callback', @(src, event) apply_object_count_filter(ax1, ax2, src));

    uicontrol('Style', 'text', 'String', 'Valor de Limiar (Contagem de Objetos)', 'Position', [(fig_width - 300) / 2, fig_height * 0.3 + 25, 300, 20], ...
                'HorizontalAlignment', 'center', 'Tag', 'label_object_threshold', 'Visible', 'off');

    % Texto estático para mostrar a contagem de objetos
    text_object_count = uicontrol('Style', 'text', 'String', 'Objetos: 0', ...
                                'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 50, 100, 20], ...
                                'HorizontalAlignment', 'center', 'Tag', 'text_object_count', 'Visible', 'off');
    
    % Caixa de entrada para valor mínimo do bwareaopen
    input_min_area = uicontrol('Style', 'edit', 'String', '50', ...  % Valor padrão 50
                            'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 75, 100, 20], ...
                            'Tag', 'input_min_area', ...
                            'Visible', 'off');  % Campo de entrada para valor da área mínima
    uicontrol('Style', 'text', 'String', 'Área Mínima (bwareaopen)', ...
                'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 50, 100, 20], ...
                'HorizontalAlignment', 'center', 'Tag', 'label_min_area', 'Visible', 'off');

    % Botão para aplicar o filtro de contagem de objetos
    apply_button_object_count = uicontrol('Style', 'pushbutton', 'String', 'Aplicar Filtro', ...
                                        'Position', [(fig_width - 100) / 2, fig_height * 0.3 - 100, 100, 30], ...
                                        'Visible', 'off', 'tag', 'apply_buttonc',...
                                        'Callback', @(src, event) apply_object_count_filter(ax1, ax2, slider_object_threshold));



    % Espera até que a janela seja fechada
    uiwait(f);
end

% Função para aplicar o filtro selecionado
function apply_filter(filter_index, ax1, ax2)
    % Verifica se uma imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar um filtro.', 'Erro de Carregamento de Imagem');
        return;
    end


    % Ocultar todos os controles inicialmente
    set(findobj('Tag', 'slider_gray'), 'Visible', 'off');
    set(findobj('Tag', 'label_gray'), 'Visible', 'off');
    set(findobj('Tag', 'slider_contrast'), 'Visible', 'off');
    set(findobj('Tag', 'label_contrast'), 'Visible', 'off');
    set(findobj('Tag', 'input_param_highpass'), 'Visible', 'off');
    set(findobj('Tag', 'label_highpass'), 'Visible', 'off');
    set(findobj('Tag', 'popup_filter_type'), 'Visible', 'off');
    set(findobj('Tag', 'label_filter_type'), 'Visible', 'off');
    set(findobj('Tag', 'apply_button'), 'Visible', 'off');
    set(findobj('Tag', 'input_param_lowpass'), 'Visible', 'off');
    set(findobj('Tag', 'label_lowpass'), 'Visible', 'off');
    set(findobj('Tag', 'popup_filter_type_lowpass'), 'Visible', 'off');
    set(findobj('Tag', 'label_filter_type_lowpass'), 'Visible', 'off');
    set(findobj('Tag', 'apply_button_lowpass'), 'Visible', 'off');
    set(findobj('Tag', 'popup_filter_type_edge'), 'Visible', 'off');
    set(findobj('Tag', 'label_filter_type_edge'), 'Visible', 'off');
    set(findobj('Tag', 'apply_button_edge'), 'Visible', 'off');
    set(findobj('Tag', 'popup_noise_type'), 'Visible', 'off');
    set(findobj('Tag', 'label_noise_type'), 'Visible', 'off');
    set(findobj('Tag', 'input_param_variance'), 'Visible', 'off');
    set(findobj('Tag', 'label_param_variance'), 'Visible', 'off');
    set(findobj('Tag', 'apply_button_noise'), 'Visible', 'off');
    set(findobj('Tag', 'slider_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'label_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'slider_watershed_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'label_watershed_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'slider_object_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'label_object_threshold'), 'Visible', 'off');
    set(findobj('Tag', 'text_object_count'), 'Visible', 'off');
    set(findobj('Tag', 'label_min_area'), 'Visible', 'off');
    set(findobj('Tag', 'input_min_area'), 'Visible', 'off');
    set(findobj('Tag', 'apply_buttonc'), 'Visible', 'off');

    % Funções específicas para cada filtro
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
            set(findobj('Tag', 'popup_filter_type'), 'Visible', 'on');
            set(findobj('Tag', 'label_filter_type'), 'Visible', 'on');
            set(findobj('Tag', 'apply_button'), 'Visible', 'on');
            apply_highpass_filter(ax2);

        case 4  % Filtro Passa-Baixa
            set(findobj('Tag', 'input_param_lowpass'), 'Visible', 'on');
            set(findobj('Tag', 'label_lowpass'), 'Visible', 'on');
            set(findobj('Tag', 'popup_filter_type_lowpass'), 'Visible', 'on');
            set(findobj('Tag', 'label_filter_type_lowpass'), 'Visible', 'on');
            set(findobj('Tag', 'apply_button_lowpass'), 'Visible', 'on');
            apply_lowpass_filter(ax2);

        case 5  % Extração de Borda
            set(findobj('Tag', 'popup_filter_type_edge'), 'Visible', 'on');
            set(findobj('Tag', 'label_filter_type_edge'), 'Visible', 'on');
            set(findobj('Tag', 'apply_button_edge'), 'Visible', 'on');  % Certifique-se de que o botão está visível
            apply_edge_filter(ax2);  % Função para aplicar o filtro de extração de borda

        case 6  % Ruído
            set(findobj('Tag', 'popup_noise_type'), 'Visible', 'on');
            set(findobj('Tag', 'label_noise_type'), 'Visible', 'on');
            set(findobj('Tag', 'input_param_variance'), 'Visible', 'on');
            set(findobj('Tag', 'label_param_variance'), 'Visible', 'on');
            set(findobj('Tag', 'apply_button_noise'), 'Visible', 'on');
            apply_noise(ax2);

        case 7  % Limiarização
            set(findobj('Tag', 'slider_threshold'), 'Visible', 'on');
            set(findobj('Tag', 'label_threshold'), 'Visible', 'on');
            apply_threshold_filter(ax1, ax2);

        case 8  % Histograma (Escala de Cinza)
            % Dimensões do monitor para centralização
            screen_width = 1920;
            screen_height = 1080;

            % Cria uma nova janela (figure) com centralização de acordo com a resolução do monitor
            fig_width = 900;
            fig_height = 600;
            f = figure('Position', [(screen_width - fig_width) / 2, (screen_height - fig_height) / 2, fig_width, fig_height], ...
                'Name', 'Processamento de Imagens', 'NumberTitle', 'off', 'Resize', 'on');
            % Eixo para exibir a imagem equalizada (abaixo da imagem original)
            ax3 = axes('Parent', f, 'Position', [0.1, 0.1, 0.35, 0.3], 'Visible', 'off');
            title(ax3, 'Imagem Equalizada (Escala de cinza)');

            % Eixo para exibir o histograma da imagem equalizada (abaixo do histograma atual)
            ax4 = axes('Parent', f, 'Position', [0.55, 0.1, 0.35, 0.3], 'Visible', 'off');
            title(ax4, 'Histograma Equalizado');

            % Eixo para exibição da imagem original
            ax11 = axes('Parent', f, 'Position', [0.1, 0.5, 0.35, 0.3]);
            title(ax11, 'Imagem (Escala de cinza)');

            % Eixo para exibição da imagem modificada
            ax22 = axes('Parent', f, 'Position', [0.55, 0.5, 0.35, 0.3]);
            title(ax22, 'Histograma');
            
            apply_histogram_equalization(ax11, ax22, ax3, ax4);
        
        case 9  % Watershed
        set(findobj('Tag', 'slider_watershed_threshold'), 'Visible', 'on');
        set(findobj('Tag', 'label_watershed_threshold'), 'Visible', 'on');
        apply_watershed_filter(ax1, ax2, findobj('Tag', 'slider_watershed_threshold'));

        case 10  % Contagem de Objetos
        set(findobj('Tag', 'slider_object_threshold'), 'Visible', 'on');
        set(findobj('Tag', 'label_object_threshold'), 'Visible', 'on');
        set(findobj('Tag', 'text_object_count'), 'Visible', 'on');
        set(findobj('Tag', 'label_min_area'), 'Visible', 'on');
        set(findobj('Tag', 'input_min_area'), 'Visible', 'on');
        set(findobj('Tag', 'apply_buttonc'), 'Visible', 'on'); 
        apply_object_count_filter(ax1, ax2, findobj('Tag', 'slider_object_threshold'));



        otherwise
            errordlg('Seleção de filtro inválida!', 'Erro');
    end
end

function apply_object_count_filter(ax2, ax1, slider)
    % Verifica se uma imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar o filtro.', 'Erro de Carregamento de Imagem');
        return;
    end

    % Obtém a imagem original, sem modificá-la
    img_original = evalin('base', 'img');

    % Faz uma cópia da imagem para ser modificada
    img_modified = img_original;

    % Obtém o valor do limiar do slider
    threshold_value = get(slider, 'Value');

    % Obtém o valor inserido na caixa de entrada para a área mínima
    min_area = str2double(get(findobj('Tag', 'input_min_area'), 'String'));

    % Verifica se o valor é válido
    if isnan(min_area) || min_area <= 0
        errordlg('Insira um valor numérico válido para a área mínima!', 'Erro');
        return;
    end

    % Exibe a imagem original no eixo ax1 (imagem original deve sempre aparecer aqui)
    axes(ax1);
    imshow(img_original, []);  % Garante que a imagem original é exibida no ax1
    title(ax1, 'Imagem Original');

    % Verifica se a imagem já é binária
    if ~islogical(img_modified)
        % Se não for binária, converte para escala de cinza, se necessário
        if size(img_modified, 3) == 3
            img_modified = rgb2gray(img_modified);
        end
        % Binariza a imagem com base no valor do limiar
        bw = im2bw(img_modified, threshold_value);
    else
        bw = img_modified;  % A imagem já está binarizada
    end

    % Remove áreas pequenas baseadas no valor mínimo de área
    bw = bwareaopen(bw, min_area);

    % Verifica se a imagem é 2D antes de aplicar o bwlabel
    if ndims(bw) ~= 2
        errordlg('A imagem deve ser uma matriz 2D após a binarização.', 'Erro');
        return;
    end

    % Aplica a função de contagem de objetos com o valor mínimo de área
    img_with_objects = object_count_filter(bw, threshold_value, min_area);

    % Atualiza o número de objetos
    [~, num_objects] = bwlabel(bw);
    set(findobj('Tag', 'text_object_count'), 'String', ['Objetos: ', num2str(num_objects)]);

    % Salva a imagem modificada na base de dados
    assignin('base', 'img_modified', img_with_objects);
end




function apply_watershed_filter(ax1, ax2, src)
    % Verifica se uma imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar o filtro.', 'Erro de Carregamento de Imagem');
        return;
    end

    % Obtém a imagem original
    img = evalin('base', 'img');

    % Obtém o valor do limiar do slider
    threshold_value = get(src, 'Value');

    % Aplica o filtro Watershed com o valor do threshold ajustável
    img_segmented = watershed_filter(img, threshold_value);

    % Exibe a imagem segmentada
    axes(ax2);
    imshow(img_segmented);
    title('Segmentação Watershed');
end

function apply_histogram_equalization(ax1, ax2, ax3, ax4)
    % Verifica se a imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar o filtro.', 'Erro de Carregamento de Imagem');
        return;
    end

    % Obtém a imagem original
    img = evalin('base', 'img');

    % Verifica se a imagem é colorida e converte para escala de cinza
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end

    % Calcula o histograma da imagem original
    histogram_values = imhist(img_gray);

    % Equaliza a imagem
    img_equalized = histeq(img_gray);

    % Calcula o histograma da imagem equalizada
    histogram_equalized = imhist(img_equalized);

    % Exibe a imagem original e o histograma no eixo ax1 e ax2
    axes(ax1);
    imshow(img_gray);
    title('Imagem Original (Escala de Cinza)');

    axes(ax2);
    bar(histogram_values);
    title('Histograma Original (Escala de Cinza)');

    % Exibe a imagem equalizada e o histograma equalizado no eixo ax3 e ax4
    axes(ax3);
    imshow(img_equalized);
    title('Imagem Equalizada (Escala de Cinza)');

    axes(ax4);
    bar(histogram_equalized);
    title('Histograma Equalizado (Escala de Cinza)');
end


function apply_threshold_filter(ax1, ax2)
    % Verifica se uma imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar um filtro.', 'Erro de Carregamento de Imagem');
        return;
    end

    % Obtém a imagem original e o valor do limiar
    img = evalin('base', 'img');
    threshold_value = get(findobj('Tag', 'slider_threshold'), 'Value');

    % Aplica o filtro de limiarização
    img_filtered = threshold_filter(img, threshold_value);

    % Exibe a imagem modificada
    assignin('base', 'img_modified', img_filtered);  % Salva a imagem modificada
    axes(ax2);
    imshow(img_filtered);
end


function apply_noise(ax2)
    img = evalin('base', 'img');
    if isempty(img)
        errordlg('Carregue uma imagem primeiro!', 'Erro');
        return;
    end

    % Obter o tipo de ruído
    noise_type_index = get(findobj('Tag', 'popup_noise_type'), 'Value');
    noise_type = {'Salt & Pepper', 'Gaussian', 'Speckle', 'Poisson', 'Uniform', 'Periodic'};
    selected_noise = noise_type{noise_type_index};

    % Obter o valor da variância ou outros parâmetros
    param_variance = str2double(get(findobj('Tag', 'input_param_variance'), 'String'));
    if isnan(param_variance) || param_variance <= 0
        errordlg('Insira um valor válido para a variância!', 'Erro');
        return;
    end

    % Aplicar o ruído baseado na escolha
    switch selected_noise
        case 'Salt & Pepper'
            img_noisy = imnoise(img, 'salt & pepper', param_variance);

        case 'Gaussian'
            img_noisy = imnoise(img, 'gaussian', 0, param_variance);

        case 'Speckle'
            img_noisy = imnoise(img, 'speckle', param_variance);

        case 'Poisson'
            img_noisy = imnoise(img, 'poisson');

        otherwise
            errordlg('Tipo de ruído inválido!', 'Erro');
            return;
    end

    assignin('base', 'img_modified', img_noisy);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_noisy);
end



function apply_edge_filter(ax2)
    % Verifica se uma imagem foi carregada
    if evalin('base', 'exist(''img'', ''var'')') == 0
        errordlg('Por favor, carregue uma imagem antes de aplicar um filtro.', 'Erro de Carregamento de Imagem');
        return;
    end

    % Obtém a imagem original
    img = evalin('base', 'img');
    filter_type = get(findobj('Tag', 'popup_filter_type_edge'), 'Value');
    filter_name = get(findobj('Tag', 'popup_filter_type_edge'), 'String');
    filter_name = filter_name{filter_type};

    % Aplica o filtro de extração de borda
    img_filtered = edge_extraction(filter_name, img);
    assignin('base', 'img_modified', img_filtered);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_filtered);
end

function apply_lowpass_filter(ax2)
    img = evalin('base', 'img');
    if isempty(img)
        errordlg('Carregue uma imagem primeiro!', 'Erro');
        return;
    end

    param_value = str2double(get(findobj('Tag', 'input_param_lowpass'), 'String'));
    if isnan(param_value) || param_value < 1
        errordlg('Insira um valor numérico válido para o parâmetro do filtro passa-baixa!', 'Erro');
        return;
    end

    % Obter o tipo de filtro do menu suspenso
    filter_type_index = get(findobj('Tag', 'popup_filter_type_lowpass'), 'Value');
    filter_type = {'média', 'mediana'};

    if strcmp(filter_type{filter_type_index}, 'média')
        img_filtered = pass_filters('low_pass_mean', img, param_value);  % Filtro Passa-Baixa Média
    elseif strcmp(filter_type{filter_type_index}, 'mediana')
        img_filtered = pass_filters('low_pass_median', img, param_value);  % Filtro Passa-Baixa Mediana
    else
        errordlg('Tipo de filtro inválido! Use "média" ou "mediana".', 'Erro');
        return;
    end

    assignin('base', 'img_modified', img_filtered);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_filtered);
end


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

    % Obter o tipo de filtro do popup menu
    filter_type_index = get(findobj('Tag', 'popup_filter_type'), 'Value');
    filter_type = {'básico', 'alto reforço'};  % Definição dos tipos de filtro disponíveis

    if strcmp(filter_type{filter_type_index}, 'básico')
        img_filtered = pass_filters('high_pass', img, param_value);  % Filtro Passa-Alta Básico
    elseif strcmp(filter_type{filter_type_index}, 'alto reforço')
        img_filtered = pass_filters('high_boost', img, param_value);  % Filtro Passa-Alta com Alto Reforço
    else
        errordlg('Tipo de filtro inválido!', 'Erro');
        return;
    end

    assignin('base', 'img_modified', img_filtered);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_filtered);
end