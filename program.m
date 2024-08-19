    % Função para carregar uma imagem
    function load_image(~, ~)
        [filename, pathname] = uigetfile({'*.png;*.jpg;*.bmp;*.tif', 'Image Files (*.png, *.jpg, *.bmp, *.tif)'}, 'Selecione a Imagem');
        if isequal(filename, 0)
            return;  % Usuário cancelou o carregamento
        end
        img = imread(fullfile(pathname, filename));
        axes(ax1);
        imshow(img);
    end

    % Função para aplicar o filtro de escala de cinza
    function apply_filter(filter_type)
        if isempty(img)
            errordlg('Carregue uma imagem primeiro!', 'Erro');
            return;
        end
    
    switch filter_type
        case 'gray'
            img_gray = rgb2gray(img);
            axes(ax2);
            imshow(img_gray);
        otherwise
            errordlg('Filtro desconhecido!', 'Erro');
        end
    end