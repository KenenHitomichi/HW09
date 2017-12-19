%% set up
Xr = [0,pi*5];  % Xr代表横坐标的范围
Yr = [0,1];     % Yr代表纵坐标的范围
nx = 1000;  % number of samples in Xr
ny = 500;   % number of samples in Yr
%nx，ny分表代表横坐标与纵坐标被分成几份。通俗来说就是横纵坐标的像素大小。也就是说，
%这张图的大小是 1000*500

% create the meshgrid coordinates in the range
xs = linspace(Xr(1), Xr(2), nx);
ys = linspace(Yr(1), Yr(2), ny);
%这里是把xr，yr分成nx，ny份

[X,Y] = meshgrid(xs,ys);
%这里是生成网格。meshgrid是网格的意思，通俗来说就是像素点，也就是图像中的每个点的位置。
%X存储的是图像中每个点的横坐标，Y存储的是图像中的每个点的纵坐标，都是 1000*500 的矩阵

%% form an image I of size(X), and has its value defined as sin(x) at every meshgrid
I = zeros(size(X)); %这里I就是 1000*500 的矩阵，每个点现在的值都是0
%fill in your code here
I = sin(X);         %这里是我偷懒发现这样可以用，就是I中每个点的值变成每个点横坐标的sin值
%fill in your code here


%% plot the image: your image should look exactly like the one in homework handout
figure(1);      %生成一个空图，编号为1
colormap(jet);  %在空图中设置一个色图jet，每个点的颜色将由一个0~1之间的值表示
pcolor(I);      %根据I中的每个点的值绘制颜色到jet中
shading interp; %暗角，用于均匀过渡颜色
axis image;     %保持横纵坐标比
axis off;       %隐藏坐标轴
