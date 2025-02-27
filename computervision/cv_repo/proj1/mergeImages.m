function frame = mergeImages(imR,imG,imB,XR,XG,XB) 
% inputs:
%   3 images -- R, G, B
%       imR
%       imG
%       imB
%   3 sets of 2xM*N indices where XR = [1,2,3,1,2,3...,M*N;
%       XR                              1,1,1,2,2,2...,M*N];
%       XG    where X(:,1) == [x1;y1];
%       XB
%
% outputs:
%   frame -- M'x N'x 3 where M'and N' are the biggest M and N which
%       contain all 3 images, offset in x,y and each image in its own plane
% 

[M,N] = size(imR); % get image size

frameR = zeros(M,N); % build image frames
frameG = zeros(M,N);
frameB = zeros(M,N);
frame  = zeros(M,N,3); % and finale rgb frame


XR_x = XR(1,:); XR_y = XR(2,:); % break up coordinates into x and y
XG_x = XG(1,:); XG_y = XG(2,:); % components
XB_x = XB(1,:); XB_y = XB(2,:);

XR_x(XR_x<1) = 1;XR_y(XR_y<1) = 1; % restrict images to search for values
XG_x(XG_x<1) = 1;XG_y(XG_y<1) = 1; % in pixels not before start of img
XB_x(XB_x<1) = 1;XB_y(XB_y<1) = 1;

XR_x(XR_x>N) = 1;XR_y(XR_y>M) = 1; % restrict images to search for value
XG_x(XG_x>N) = 1;XG_y(XG_y>M) = 1; % in pixels not after end of img
XB_x(XB_x>N) = 1;XB_y(XB_y>M) = 1;

iR = sub2ind([M,N],XR_y,XR_x); % create linear indices based on the revised
iG = sub2ind([M,N],XG_y,XG_x); % indiced made above
iB = sub2ind([M,N],XB_y,XB_x);

linear = 1:length(iR); % make a clean linear index (since r wasn't moved)

frameR(linear) = imR(iR); % map coordinates from old img to new frame
frameG(linear) = imG(iG);
frameB(linear) = imB(iB);

frame(:,:,1) = frameR; % combine colored frames into full rgb image
frame(:,:,2) = frameG;
frame(:,:,3) = frameB;
end