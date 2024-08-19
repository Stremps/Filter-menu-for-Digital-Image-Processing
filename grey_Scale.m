% Carregar imagem desejada
filename = 'test.jpg';
img = imread(filename);

% Imprime a imagem criada
imshow(img);
title('Original Image');

% Pausa para visualizar a imagem original
pause(2);

% Converte a imagem para escala de cinza
img_gray = rgb2gray(img);

% Exibe a imagem em escala de cinza
imshow(img_gray);
title('Imagem em Escala de Cinza');


uiwait;