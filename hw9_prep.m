%% set up
Xr = [0,pi*5];  % range of X
Yr = [0,1];     % range of Y
nx = 1000;  % number of samples in Xr
ny = 500;   % number of samples in Yr

% create the meshgrid coordinates in the range
xs = linspace(Xr(1), Xr(2), nx);
ys = linspace(Yr(1), Yr(2), ny);
[X,Y] = meshgrid(xs,ys);        

%% form an image I of size(X), and has its value defined as sin(x) at every meshgrid
I = zeros(size(X));
%fill in your code here
I = sin(X);
%fill in your code here


%% plot the image: your image should look exactly like the one in homework handout
figure(1);
colormap(jet);
pcolor(I);
shading interp;
axis image;
axis off;