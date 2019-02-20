function [] = display_normal_vectors(height_map, p, q)
    
s = 9;
[w, h, ~] = size(height_map);

[X, Y] = meshgrid(1:s:h, 1:s:w);
figure();
[U, V, W] = surfnorm(X, Y, height_map(1:s:end, 1:s:end));
quiver3(X, Y, height_map(1:s:end, 1:s:end), q(1:s:end, 1:s:end), p(1:s:end, 1:s:end), W, 0.5);

end