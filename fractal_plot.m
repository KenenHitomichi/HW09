function fractal_plot   
    % a simple UI for Mandelbrot/Julia fractal set plot
    hm = figure(1);
    title('Mandelbrot set (pick a point to initialize a Julia set)');
    axis off;
    hold on;
    hj = figure(2);
    title('Julia set (pick two corners to zoom in; or double click to stop)');
    axis off;
    hold on;
    
    set(hm, 'Position', [100,100, 400,400]);
    set(hj, 'Position', [500,100, 400,400]);
    mXr = [-2.0, .5];
    mYr = [-1.25, 1.25];
    k = 400;
    figure(1);
    Mandelbrot_plot(mXr, mYr, k);
    while true
        disp('pick a point to initialize a Julia set');
        [x,y] = ginput(1);
        c =  mXr(1) + x/400*(mXr(2)-mXr(1)) +(mYr(1)+y/400*(mYr(2)-mYr(1)))*1i

        jXr = [-2,2];
        jYr = [-2,2];    
        figure(2);
        while true
            Julia_plot(c, jXr, jYr, k);
            disp('zoom-in by choosing two corners of a bounding box\or double-click to stop');
            [x, y] = ginput(2);
            if max(x) - min(x) < 1e-7
                break
            end
            jXr = [jXr(1) + x(1)/k*(jXr(2)-jXr(1)), jXr(1) + x(2)/k*(jXr(2)-jXr(1))];
            jYr = [jYr(1) + y(1)/k*(jYr(2)-jYr(1)), jYr(1) + y(2)/k*(jYr(2)-jYr(1))];
            jXr = sort(jXr);
            jYr = sort(jYr);
            disp([jXr, jYr]);
        end
        figure(1);
    end
end

function f = Mtrust(x,y)
    f = 1;
    z = complex(0,0);
    c = complex(x,y);
    for i = 1:100
        z = z*z + c;
        if abs(z)>=2
            f = 0;
            return
        end
    end
end

function f = Jtrust(x,y,c)
    f = 1;
    z = complex(x,y);
    for i = 1:100
        z = z*z + c;
        if abs(z)>=2
            f = 0;
            return
        end
    end
end

function Mandelbrot_plot(Xr, Yr, k)
    xs = linspace(Xr(1,1),Xr(1,2),k);
    ys = linspace(Yr(1,1),Yr(1,2),k);
    [X, Y] = meshgrid(xs,ys);
    M = zeros(size(X));  %an empty image yet
    %% complete the image for Mandelbrot set
    for x = 1:k
        for y = 1:k
            M(x,y) = Mtrust(xs(x),ys(y));
        end
    end

    %% plot the Mandelbrot set
    colormap(jet);
    pcolor(M);
    shading interp;
    axis image;
    axis off;
end


function Julia_plot(c, Xr, Yr, k)
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