function img_labeled = object_count_filter(img, threshold_value, min_area)
    % Converte para escala de cinza, se necessário
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Binariza a imagem com base no valor do limiar
    bw = im2bw(img, threshold_value);

    % Remove pequenas áreas ruidosas de acordo com o valor mínimo fornecido
    bw = bwareaopen(bw, min_area);

    % Rotula os objetos
    [labeled_img, num_objects] = bwlabel(bw);

    % Exibe a imagem original com os contornos e números
    imshow(img);
    hold on;

    % Calcula as propriedades dos objetos, incluindo o centróide
    props = regionprops(labeled_img, 'Centroid');

    % Desenha as bordas dos objetos e adiciona os números
    boundaries = bwboundaries(bw);
    for k = 1:num_objects
        boundary = boundaries{k};
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2); % Contorno em vermelho

        % Adiciona o número do objeto
        centroid = props(k).Centroid;
        text(centroid(1), centroid(2), sprintf('%d', k), 'Color', 'b', ...
            'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end
    hold off;

    img_labeled = img; % Retorna a imagem para manter a consistência
end
