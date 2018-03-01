function showPoints(IControlPoints)
    n = size(IControlPoints(:,1));
    axis on
    hold on;
    color = ['r','b'];
    for i = 1:n
        plot(IControlPoints(i,1),IControlPoints(i,2), strcat(color(IControlPoints(i,3)),'+'), 'MarkerSize', 7, 'LineWidth', 1);
    end