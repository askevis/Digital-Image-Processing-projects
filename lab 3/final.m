function image_r = main()

clear all;
close all;

% creating 15x15 gaussian filter with deviation=20
gfilter = fspecial('gaussian', [15 15], 20);

%loading the original image
image = imread('lena_gray_512.tif');
figure('Name','Initial image');
imshow(image);

%zero padding the image to fit the kernel size
padded_image = padarray(image,[7 7],0,'both');

%convolve the padded image with the gaussian filter
convImage = convolve(padded_image,gfilter);

%convert the convoluted one to uint type 
convImage2 = uint8(convImage);
figure('Name','Convoluted image');
imshow(convImage2);

conv_resized = imresize(convImage2,[512 512]);
disp('mse between the original image and the convoluted one');
mse_image_convImage = immse(image,conv_resized)
disp('Peak signal to noise ratio');
[peaksnr, snr] = psnr(conv_resized, image)

%%%%%%exercise 2%%%%%%
%compute the convoluted image using conv2 function
%here we use same argument cause the convoluted image should be the same
%size as the original one
convoluted = conv2(double(image),gfilter,'same');
%convert the convoluted one to uint type 
convoluted1 = uint8(convoluted);
figure('Name','Convoluted image');
imshow(convoluted1);

disp('mse between the original image and the convoluted one, exercise 2');
mse_ex2 = immse(image,convoluted1)
disp('Peak signal to noise ratio, exercise 2');
[peak_2 snr_2] = psnr(image, convoluted1)


%%%%%exercise 3%%%%%%%%%%%%
%compute the convoluted image using imfilter function
convoluted3 = imfilter(image,gfilter);
%convert the convoluted one to uint type 
convoluted4 = uint8(convoluted3);
figure('Name','Convoluted image');
imshow(convoluted4);

disp('mse between the original image and the convoluted one, exercise 3');
mse_ex3 = immse(image,convoluted4)
disp('Peak signal to noise ratio, exercise 3');
[peak_3 snr_3] = psnr(image, convoluted4)



end

function conv = convolve(I, k);
    I = double(I);
    [i_rows i_columns] = size(I);
    k_r = size(k,1) - 1;
    for i = 1:i_rows-k_r
        for j =1:i_columns-k_r
            array = I(i:i+k_r, j:j+k_r).*k;
            conv(i,j)=sum(array(:));
        end
    end

end

