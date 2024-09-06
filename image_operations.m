function image_operations(action, ax1, ax2)
    switch action
        case 'load'
            [filename, pathname] = uigetfile({'*.png;*.jpg;*.bmp;*.tif', 'Image Files (*.png, *.jpg, *.bmp, *.tif)'}, 'Selecione a Imagem');
            if isequal(filename, 0)
                return;  % Usuário cancelou o carregamento
            end
            img = imread(fullfile(pathname, filename));
            axes(ax1);
            imshow(img);
            assignin('base', 'img', img);  % Armazena a imagem na base de dados para uso global
            assignin('base', 'img_modified', img);  % Inicializa a imagem modificada como a original
            
        case 'save'
            img_modified = evalin('base', 'img_modified');
            if isempty(img_modified)
                errordlg('Não há imagem modificada para salvar!', 'Erro');
                return;
            end
            [filename, pathname] = uiputfile({'*.png;*.jpg;*.bmp', 'Image Files (*.png, *.jpg, *.bmp)'}, 'Salvar Imagem Como');
            if isequal(filename, 0)
                return;  % Usuário cancelou o salvamento
            end
            imwrite(img_modified, fullfile(pathname, filename));
    end
end
