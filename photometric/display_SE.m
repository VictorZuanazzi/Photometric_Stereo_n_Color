function display_SE( name, normals, SE )
%SHOW_RESULTS display albedo, normal and computational errors

[h, w, ~] = size(normals);

% plot the results
fig1 = figure;
[X, Y] = meshgrid(1:w, 1:h);
surf(X, Y, SE, gradient(SE));
title('Integrability check: (dp / dy - dq / dx) ^2 ');
saveas(fig1, name)

end
