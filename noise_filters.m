function img_noisy = noise_filters(noise_type, img, param_variance)
    switch noise_type
        case 'Salt & Pepper'
            img_noisy = imnoise(img, 'salt & pepper', param_variance);

        case 'Gaussian'
            img_noisy = imnoise(img, 'gaussian', 0, param_variance);

        case 'Speckle'
            img_noisy = imnoise(img, 'speckle', param_variance);

        case 'Poisson'
            img_noisy = imnoise(img, 'poisson');

        otherwise
            error('Tipo de ruído não reconhecido.');
    end
end
