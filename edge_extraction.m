function img_filtered = edge_extraction(filter_type, img)
    % Verifica se a imagem é colorida e converte para escala de cinza se necessário
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Converte para double para evitar problemas de overflow/underflow
    img = im2double(img);

    switch filter_type
        case 'roberts'
            h1 = [1 0; 0 -1]; % Filtro Roberts
            h2 = [0 1; -1 0];
            img_filtered = sqrt(imfilter(img, h1, 'replicate').^2 + imfilter(img, h2, 'replicate').^2);

        case 'prewitt'
            h1 = fspecial('prewitt'); % Filtro Prewitt horizontal
            h2 = h1';
            img_filtered = sqrt(imfilter(img, h1, 'replicate').^2 + imfilter(img, h2, 'replicate').^2);

        case 'sobel'
            h1 = fspecial('sobel'); % Filtro Sobel horizontal
            h2 = h1';
            img_filtered = sqrt(imfilter(img, h1, 'replicate').^2 + imfilter(img, h2, 'replicate').^2);

        case 'zerocross'
            % Aplica o filtro de extração de borda Zero-Crossing
            h = fspecial('laplacian', 0.2);
            img_filtered = edge(img, 'zerocross',0, h);

        case 'log'
            % Filtro Laplacian of Gaussian (LoG)
            img_filtered = edge(img, 'log');

        case 'canny'
            % Filtro Canny
            img_filtered = edge(img, 'canny');
        
        otherwise
            error('Tipo de filtro de extração de borda não reconhecido.');
    end
    
    % Garante que a imagem filtrada esteja no intervalo [0, 1]
    img_filtered = max(min(img_filtered, 1), 0);
end
