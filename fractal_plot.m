function fractal_plot   %主函数
    % a simple UI for Mandelbrot/Julia fractal set plot
    hm = figure(1);     %生成空图，编号为1
    title('Mandelbrot set (pick a point to initialize a Julia set)');
                        %定义图1标题
    axis off;           %隐藏坐标轴
    hold on;            %固定图像使其不被覆盖
    hj = figure(2);     %生成另一张空图，编号为2
    title('Julia set (pick two corners to zoom in; or double click to stop)');
                        %定义图2标题（title是就近选择图）
    axis off;
    hold on;

    set(hm, 'Position', [100,100, 400,400]);
    set(hj, 'Position', [500,100, 400,400]);
    mXr = [-2.0, .5];   %设置mandelbrot图横坐标范围
    mYr = [-1.25, 1.25];%设置mandelbrot纵坐标范围
    k = 400;            %设置分成几份（分辨率）
    figure(1);          %切换到图1，以下操作在图1中进行
    Mandelbrot_plot(mXr, mYr, k);
    while true          %无限运行
        disp('pick a point to initialize a Julia set');
        [x,y] = ginput(1);
                        %获取一个点，横坐标欸x，纵坐标给y
        c =  mXr(1) + x/400*(mXr(2)-mXr(1)) +(mYr(1)+y/400*(mYr(2)-mYr(1)))*1i
                        %根据x，y计算出c值
        jXr = [-2,2];
        jYr = [-2,2];
        figure(2);      %切换到图2，以下操作在图2中进行
        while true
            Julia_plot(c, jXr, jYr, k);
            disp('zoom-in by choosing two corners of a bounding box\or double-click to stop');
            [x, y] = ginput(2);
                        %选择两个点
            if max(x) - min(x) < 1e-7
                break
            end         %如果两次点在同一行，退出循环
            jXr = [jXr(1) + x(1)/k*(jXr(2)-jXr(1)), jXr(1) + x(2)/k*(jXr(2)-jXr(1))];
            jYr = [jYr(1) + y(1)/k*(jYr(2)-jYr(1)), jYr(1) + y(2)/k*(jYr(2)-jYr(1))];
            jXr = sort(jXr);
            jYr = sort(jYr);
                        %根据取的两个点对横纵坐标范围进行缩放，最终效果是放大两点中的图像
            disp([jXr, jYr]);
        end
        figure(1);      %重新切换到图1
    end
end

function f = Mtrust(x,y)  %判断c是否属于 Mandelbrot Set
    f = 1;                %f表示是否满足，满足为1，不满足为0
    z = complex(0,0);     %Z0为0
    c = complex(x,y);
    for i = 1:100         %执行100次
        z = z*z + c;      %递推
        if abs(z)>=2      %如果模超过或等于2，说明已经不成立了
            f = 0;
            return        %结束函数，返回f
        end
    end
    %函数结束默认返回f
end

function f = Jtrust(x,y,c)%c是一个给定的常数
    f = 1;
    z = complex(x,y);     %得到Z0
    for i = 1:100
        z = z*z + c;
        if abs(z)>=2
            f = 0;
            return
        end
    end
end

function Mandelbrot_plot(Xr, Yr, k)          %Xr,Yr是坐标范围，k是点个数
    xs = linspace(Xr(1,1),Xr(1,2),k);
    ys = linspace(Yr(1,1),Yr(1,2),k);        %得到xs和ys，由范围均分成k份
    [X, Y] = meshgrid(xs,ys);                %生成网格
    M = zeros(size(X));  %an empty image yet %一开始默认各个点颜色为0
    %% complete the image for Mandelbrot set
    for x = 1:k
        for y = 1:k                          %遍历每个点
            M(x,y) = Mtrust(xs(x),ys(y));    %检验该点是否符合
        end
    end

    %% plot the Mandelbrot set               %画图，同hw9_prep.m
    colormap(jet);
    pcolor(M);
    shading interp;
    axis image;
    axis off;
end


function Julia_plot(c, Xr, Yr, k)           %类似Mandelbrot_plot
    xs = linspace(Xr(1,1),Xr(1,2),k);
    ys = linspace(Yr(1,1),Yr(1,2),k);
    [X,Y] = meshgrid(xs,ys);
    J = zeros(size(X));  %an empty image

    %% complete the image for the Julia set
    for x = 1:k
        for y = 1:k
            J(x,y) = Jtrust(xs(x),ys(y),c);
        end
    end

    %% plot the Julia set
    colormap(jet);
    pcolor(J);
    shading interp;
    axis image;
    axis off;
end
