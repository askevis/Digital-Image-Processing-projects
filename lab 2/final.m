
function m = main()
clear all;
close all;

%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%

% Compute_Mean / EROTIMA 1 %
function mean = Compute_Mean(image, kernel)
    
    [KernelRows , KernelColumns] = size(kernel)%kernel size computing
    [ImageRows, ImageColumns] = size(image)%image size computing

    %zero padding
    AddedRows = floor(KernelRows/2)
    AddedColumns = floor(KernelColumns/2)
    Padded_Image = padarray (image,[AddedRows AddedColumns])
    [Padded_Image_Rows, Padded_Image_Columns]=size(Padded_Image);

    for i = (AddedRows+1):(ImageRows-1)
        for j = (AddedColumns+1):(ImageColumns-1)
            array = Padded_Image((i-AddedRows):(i+AddedRows), (j-AddedColumns):(j+AddedColumns));
            array_sum = (sum(array(:)))/(KernelRows * KernelColumns);
            mean(i-AddedRows,j-AddedColumns) = uint8(ceil(array_sum));      
        end
    end
end

% Compute_Median / EROTIMA 2 %
  function medn = Compute_Median(image,k1, k2)    
    
     [ImageRows, ImageColumns] = size(image)%image size computing
    
    %replicate padding
     AddedRows = floor(k1/2)
     AddedColumns = floor(k2/2)
     Padded_Image_Replicate = padarray (image,[AddedRows AddedColumns],'replicate')

    for i = (AddedRows+1):(ImageRows-1)
        for j = (AddedColumns+1):(ImageColumns-1)
            array = Padded_Image_Replicate((i-AddedRows):(i+AddedRows),(j-AddedColumns):(j+AddedColumns));
            medn(i-AddedRows,j-AddedColumns) = median(median(sort(array)));      
        end
    end    
  end


% Compute_Min / EROTIMA 3 %
function mn = Compute_Min(image,ker1, ker2)

    [ImageRows, ImageColumns] = size(image)%image size computing
    
    %symmetric padding
    AddedRows = floor(ker1/2)
    AddedColumns = floor(ker2/2)  
    Padded_Image_Symm = padarray (image,[AddedRows AddedColumns],'symmetric','both');
    [Padded_Image_Rows, Padded_Image_Columns]=size(Padded_Image_Symm);
    
    for i = (AddedRows+1):(ImageRows-1)
        for j = (AddedColumns+1):(ImageColumns-1)
            array = Padded_Image_Symm((i-AddedRows):(i+AddedRows), (j-AddedColumns):(j+AddedColumns));
            array_min = min(min(array));
            mn(i-AddedRows,j-AddedColumns) = uint8(array_min);      
        end
    end
end


% Compute_Max / EROTIMA 3 %
function mx = Compute_Max(image,ker1, ker2)

    [ImageRows, ImageColumns] = size(image)%image size computing
    
    %symmetric padding
    AddedRows = floor(ker1/2)
    AddedColumns = floor(ker2/2)    
    Padded_Image_Symm = padarray (image,[AddedRows AddedColumns],'symmetric','both');
    [Padded_Image_Rows, Padded_Image_Columns]=size(Padded_Image_Symm)
    
    for i = (AddedRows+1):(ImageRows-1)
        for j = (AddedColumns+1):(ImageColumns-1)
            array = Padded_Image_Symm((i-AddedRows):(i+AddedRows), (j-AddedColumns):(j+AddedColumns));
            array_max = max(max(array));
            mx(i-AddedRows,j-AddedColumns) = uint8(array_max);      
        end
    end
end

%%%%%%%%%%%% FUNCTION CALLING %%%%%%%%%%%%    
            kernel_size3 = 3
            kernel_size5 = 5
            kernel_size7 = 7
            kernel_size9 = 9
            kernel_size11 = 11
           
%%%%%%%%%% erotima 1 %%%%%%%%%%%           
            image_mean=imread('Mean_Image1.jpeg');
            figure('Name','Mean_Image1');
            im_grey = image_mean(:, :, 2); %making image grey
            imshow(im_grey);
                       
            filter_3x3 = (zeros(kernel_size3,kernel_size3))           
            returned_mean_3x3 = Compute_Mean(im_grey, filter_3x3)
            figure('Name','Returned image - 3x3 kernel -  mean function');
            imshow(returned_mean_3x3)
            
            filter_5x5 = (zeros(kernel_size5,kernel_size5))            
            returned_mean_5x5 = Compute_Mean(im_grey, filter_5x5)
            figure('Name','Returned image - 5x5 kernel -  mean functionl');
            imshow(returned_mean_5x5)
            
            filter_9x9 = (zeros(kernel_size9,kernel_size9))
            returned_mean_9x9 = Compute_Mean(im_grey, filter_9x9)
            figure('Name','Returned image - 9x9 kernel -  mean function');
            imshow(returned_mean_9x9)
        
%%%%%%%%%% erotima 2 %%%%%%%%%%%              
            image_median=imread('Median_Image1.png');
            figure('Name','Median_Image2');
            imshow(image_median);

            returned_median_3x3 = Compute_Median(image_median, kernel_size3, kernel_size3)
            figure('Name','Returned image - 3x3 kernel -  median function');
            imshow(returned_median_3x3)
            
            returned_median_5x7 = Compute_Median(image_median, kernel_size5, kernel_size7)
            figure('Name','Returned image - 5x7 kernel -  median function');
            imshow(returned_median_5x7)

            returned_median_9x11 = Compute_Median(image_median, kernel_size9, kernel_size11)
            figure('Name','Returned image - 9x11 kernel -  median function');
            imshow(returned_median_9x11)      
        
%%%%%%%%%% erotima 3 %%%%%%%%%%% 
           %%%%%   min  %%%%
           %image 1%
            image_min1=imread('Min_Max_Image1.jpeg');
            figure('Name','Min Max image 1');
            im_grey_min1 = image_min1(:, :, 2);
            imshow(im_grey_min1);
            
            returned_min1_3x5 = Compute_Min(im_grey_min1, kernel_size3, kernel_size5)
            figure('Name','Returned image 1 - 3x5 kernel -  min function');
            imshow(returned_min1_3x5)
            
            returned_min1_5x5 = Compute_Min(im_grey_min1, kernel_size5, kernel_size5)
            figure('Name','Returned image 1 - 5x5 kernel -  min function');
            imshow(returned_min1_5x5)
            
            returned_min1_7x7 = Compute_Min(im_grey_min1, kernel_size7, kernel_size7)
            figure('Name','Returned image 1 - 7x7 kernel -  min function');
            imshow(returned_min1_7x7)
            
           %image 2%
            image_min2=imread('Min_Max_Image2.jpeg');
            figure('Name','Min Max image 2');
            im_grey_min2 = image_min2(:, :, 2);
            imshow(im_grey_min2);
            
            returned_min2_3x5 = Compute_Min(im_grey_min2, kernel_size3, kernel_size5)
            figure('Name','Returned image 2 - 3x5 kernel -  min function');
            imshow(returned_min2_3x5)
            
            returned_min2_5x5 = Compute_Min(im_grey_min2, kernel_size5, kernel_size5)
            figure('Name','Returned image 2 - 5x5 kernel -  min function');
            imshow(returned_min2_5x5)
            
            returned_min2_7x7 = Compute_Min(im_grey_min2, kernel_size7, kernel_size7)
            figure('Name','Returned image 2 - 7x7 kernel -  min function');
            imshow(returned_min2_7x7)
            
        
            %%%%%   max  %%%%              
            %image 1%
            image_max1=imread('Min_Max_Image1.jpeg');
            figure('Name','Min Max image 1');
            im_grey_max1 = image_max1(:, :, 2);
            imshow(im_grey_max1);
            
            returned_max1_3x5 = Compute_Max(im_grey_max1, kernel_size3, kernel_size5)
            figure('Name','Returned image 1 - 3x5 kernel -  max function');
            imshow(returned_max1_3x5)
            
            returned_max1_5x5 = Compute_Max(im_grey_max1, kernel_size5, kernel_size5)
            figure('Name','Returned image 1 - 5x5 kernel -  max function');
            imshow(returned_max1_5x5)
            
            returned_max1_7x7 = Compute_Max(im_grey_max1, kernel_size7, kernel_size7)
            figure('Name','Returned image 1 - 7x7 kernel -  max function');
            imshow(returned_max1_7x7)
            
           %image 2%
            image_max2=imread('Min_Max_Image2.jpeg');
            figure('Name','Min Max image 2');
            im_grey_max2 = image_max2(:, :, 2);
            imshow(im_grey_max2);
            
            returned_max2_3x5 = Compute_Max(im_grey_max2, kernel_size3, kernel_size5)
            figure('Name','Returned image 2 - 3x5 kernel -  max function');
            imshow(returned_max2_3x5)
            
            returned_max2_5x5 = Compute_Max(im_grey_max2, kernel_size5, kernel_size5)
            figure('Name','Returned image 2 - 5x5 kernel -  max function');
            imshow(returned_max2_5x5)
            
            returned_max2_7x7 = Compute_Max(im_grey_max2, kernel_size7, kernel_size7)
            figure('Name','Returned image 2 - 7x7 kernel -  max function');
            imshow(returned_max2_7x7)


end %main end

