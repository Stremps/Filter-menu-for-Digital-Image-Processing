function img_filtered = threshold_filter(img, threshold_value)
    % Verifica se a imagem é colorida e converte para escala de cinza se necessário
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Converte para double para realizar as operações de limiarização
    img = im2double(img);

    % Aplica a limiarização
    img_filtered = img > threshold_value;
end
