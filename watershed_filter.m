function img_segmented = watershed_filter(img, threshold_value)
    % Verifica se a imagem é colorida e converte para escala de cinza, se necessário
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Passo 1: Aplicar filtro de mediana para reduzir o ruído
    img_filtered = medfilt2(img, [5 5]);

    % Passo 2: Calcular o gradiente da imagem
    gmag = imgradient(img_filtered);

    % Passo 3: Binarizar a imagem usando o valor do slider
    bw = im2bw(img_filtered, threshold_value);

    % Passo 4: Calcular a distância transformada
    D = -bwdist(~bw);
    D(~bw) = -Inf;

    % Passo 5: Aplicar a segmentação Watershed
    L = watershed(D);

    % Passo 6: Colorir as regiões segmentadas
    img_segmented = label2rgb(L, 'jet', 'w');
end
