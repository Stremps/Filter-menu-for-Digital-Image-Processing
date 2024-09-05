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
        case 'high_boost'  % Filtro Passa-Alta com Alto Reforço
            A = param;  % O parâmetro agora é 'A' para o filtro de alto reforço
            h = fspecial('average', 3);  % Filtro passa-baixa com kernel de média
            img_lowpass = imfilter(img, h, 'replicate');  % Aplica o filtro passa-baixa
            img_filtered = A * img - img_lowpass;  % Aplica a fórmula do filtro de alto reforço
        case 'low_pass_mean'  % Filtro Passa-Baixa Média
            h = fspecial('average', [param param]);  % Filtro passa-baixa com kernel de média de tamanho param x param
            img_filtered = imfilter(img, h, 'replicate');  % Aplica o filtro passa-baixa

        case 'low_pass_median'  % Filtro Passa-Baixa Mediana
            img_filtered = medfilt2(img, [param param]);  % Filtro mediano com vizinhança de tamanho param x param


            
        % Outras opções de filtros serão adicionadas aqui posteriormente

        otherwise
            error('Tipo de filtro não reconhecido.');
    end
    
    % Garante que a imagem filtrada esteja no intervalo [0, 1]
    img_filtered = max(min(img_filtered, 1), 0);
end
