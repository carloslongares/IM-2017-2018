function [imageOv,binaryMask] =  calculateOverlapPoints(IControlPoints,image,intensity)
%How to use it

% IControlPoints -> Points
% Image -> Single Image
% Intensity -> 1..10 
% 
% imgOv = showOverlapPoints(points,imagenes(:,:,1),3);


    nx = size(image,1);
    ny = size(image,2);
    image_d = double(image);
    
    image_rgb = zeros(nx,ny,3)+255;
    binaryMask = zeros(nx,ny,3);
    
    for fx = 1:nx
        for fy = 1:ny
            class = IControlPoints(fy+((fx-1)*ny),3);
            
             
             if class==1.0
             binaryMask(fx,fy) = 1;
             image_rgb(fx,fy,1) = (4/max(image_d(fx,fy,1)))/2 + image_d(fx,fy,1)/(100*intensity) ;
             image_rgb(fx,fy,2) = (1/max(image_d(fx,fy,1)))/10 + image_d(fx,fy,1)/850 ;
             image_rgb(fx,fy,3) = (1/max(image_d(fx,fy,1)))/10 + image_d(fx,fy,1)/850 ;
             
            
            else
                
             image_rgb(fx,fy,1) = (1/max(image_d(fx,fy,1)))/10 + image_d(fx,fy,1)/850 ;
             image_rgb(fx,fy,2) = (1/max(image_d(fx,fy,1)))/10 + image_d(fx,fy,1)/850 ;
             image_rgb(fx,fy,3) = (4/max(image_d(fx,fy,1)))/2 + image_d(fx,fy,1)/(100*intensity) ;
             
                
            end
            
                       
        end
    end
    
     
     imageOv = image_rgb;  

    