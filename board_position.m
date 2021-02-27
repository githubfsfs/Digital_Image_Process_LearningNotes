function im = board_position(row,col)

    % Load Image
    im = imread('chess.png');
    % Obtain the size of the image
    [rows, columns] = size(im);
    
    % Calculate the board size 
    board_size = rows/8;
    %����Ϊ8��8
    
    % Calculate the require position
    row_start = row * board_size + 1;
    col_start = col * board_size + 1;
    
    row_end = row_start + board_size - 1;
    col_end = col_start + board_size - 1;
    
    % Crop region starting at (100,120)
    im_crop = im(row_start : row_end,col_start:col_end,:);

    im_gray = rgb2gray(im_crop);
    
    sig = zeros(size(im));
    sig(row_start : row_end,col_start:col_end,:,1) = 255;
    sig = uint8(sig);%��Ȼ���渳ֵ����0~255��������sig����ʱ��Ĭ������Ϊdouble,����Ҫ��uint8����תΪuint8type
    pos = imlincomb(0.5,im,0.5,sig,'uint8');
    figure
    imshow(pos)
    xlabel('column')
    ylabel('row')
    impixelinfo;
    % Detemien how many zero(white) values in the image
    n = nnz(im_gray)
    % returns the number of nonzero elements in matrix X.
    m = numel(im_gray)
    % returns the number of elements, n, in array A, equivalent to prod(size(A)).
    
    if all(im_gray(:) == im_gray(1))
        disp('Empty board');
    else
        white_pixel = (n/m) * 100%value in (0,1]
        
        if white_pixel > 85
            disp('white piece');%���ǰ���ռ�����������ΪΪ����
        else
            disp('black piece');
        end
    end

    % Display the croped image
    figure
    imshow(im_gray)

end