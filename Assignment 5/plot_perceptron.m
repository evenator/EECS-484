%function to plot a 2D perceptron as a line, given weights
function plot_perceptron(weights)
    deltax = .2;
    bias = weights(1);
    sqrt(dot(weights(2:3),weights(2:3)))
    point = weights(2:3) * (-bias) / sqrt(dot(weights(2:3),weights(2:3)))
    slope = - point(1) / point(2);
    x = [point(1)-deltax, point(1), point(1)+deltax];
    y = [point(2)-deltax*slope, point(2), point(2)+deltax*slope];
    plot(x,y);
end