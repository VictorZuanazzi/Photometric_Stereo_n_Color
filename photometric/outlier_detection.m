%% Face
[image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));



p = double(p);
q = double(q);
[h, w] = size(p);
height_map = zeros(h, w, 'double');

for wi = 2:w
        height_map(1, wi) = height_map(1, wi-1)+p(1, wi);
end      
for wi = 1:w
    for hi = 2:h
        height_map(hi, wi) = height_map(hi-1, wi)+q(hi, wi);
    end
end
height_m{1} = height_map;
show_model(albedo, height_map);

count = 1;
fill_method = ["previous"; "nearest";];
find_method = ["quartiles"];
dimension = [1 2];
for i = 1:2
    count = count + 1;
    height_m{count} = filloutliers(height_m{1}, fill_method(i),find_method(1),2);  
    height_m{count} = filloutliers(height_m{count}, fill_method(i),find_method(1),1);  
    show_model(albedo, height_m{count});
    sprintf("%d %s %s", count, fill_method(i),find_method(1))
    
end
