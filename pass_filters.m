function img_filtered = pass_filters(filter_type, img, param)
    % Verifica se a imagem é colorida e converte para escala de cinza se necessário
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Converte para double para evitar problemas de overflow/underflow
    img = im2double(img);

    switch filter_type
        case 'high_pass'  % Filtro Passa-Alta
            % Define um kernel passa-alta básico (máscara de laplaciano) com o parâmetro
            h = fspecial('laplacian', param);
            % Aplica o filtro passa-alta
            img_filtered = imfilter(img, h, 'replicate');
            
        % Outras opções de filtros serão adicionadas aqui posteriormente

        otherwise
            error('Tipo de filtro não reconhecido.');
    end
    
    % Garante que a imagem filtrada esteja no intervalo [0, 1]
    img_filtered = max(min(img_filtered, 1), 0);
end
