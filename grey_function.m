function grey_function(~, ax1, ax2)
    % Carrega a imagem original da base de dados
    img = evalin('base', 'img');
    if isempty(img)
        errordlg('Carregue uma imagem primeiro!', 'Erro');
        return;
    end

    % Obtém valores dos sliders
    slider_gray = findobj('Tag', 'slider_gray');
    slider_contrast = findobj('Tag', 'slider_contrast');
    
    % Verifica se os sliders estão corretamente definidos
    if isempty(slider_gray) || isempty(slider_contrast)
        errordlg('Erro ao obter valores dos sliders!', 'Erro');
        return;
    end

    gray_value = get(slider_gray, 'Value') / 100;
    contrast_value = get(slider_contrast, 'Value');

    % Converte para escala de cinza ajustando o brilho
    img_gray = rgb2gray(img);
    img_gray = im2double(img_gray);  % Garante que img_gray esteja no intervalo [0, 1]
    
    % Aplica o valor de escala de cinza
    img_gray = img_gray * gray_value;

    % Ajusta contraste
    img_contrast = img_gray * (1 + contrast_value / 100);
    img_contrast = max(min(img_contrast, 1), 0);  % Garante que os valores estejam no intervalo [0, 1]

    % Exibe a imagem modificada
    img_modified = img_contrast;
    assignin('base', 'img_modified', img_modified);  % Salva a imagem modificada na base de dados
    axes(ax2);
    imshow(img_modified);
end
