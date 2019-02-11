function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface

if nargin == 2
    path_type = 'column';
end

p = double(p);
q = double(q);

[h, w] = size(p);
height_map = zeros(h, w, 'double');

switch path_type
    case 'column'
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        for y = 2:h
            height_map(y, 1) = height_map(y-1, 1)+ q(y, 1);
        end
        
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value  
        for y = 1:h
            for x = 2:w
                height_map(y, x) = height_map(y, x-1)+p(y, x);
            end
        end
        
                    
    case 'row'
        % top left corner of height_map is zero
        % for each pixel in the top row of height_map
        %   height_value = previous_height_value + corresponding_p_value
        for x = 2:w
            height_map(1, x) = height_map(1, x-1)+p(1, x);
        end
        
        % for each columns
        %   for each element of the columns except for top one
        %       height_value = previous_height_value + corresponding_q_value
        for x = 1:w
            for y = 2:h
                height_map(y, x) = height_map(y-1, x)+q(y, x);
            end
        end

    case 'average'
        %height_map by row
        row_height_map = construct_surface( p, q, 'row' );
        
        %height_map by row
        column_height_map = construct_surface( p, q, 'column' );

        %average of the two
        height_map = (row_height_map + column_height_map) / 2;
        
    case 'm_average'
        %height_map by row
        row_height_map = construct_surface( p, q, 'row' );
        
        %height_map by row
        column_height_map = construct_surface( p, q, 'column' );
        
        %harmonic average of the two
        height_map = (row_height_map + column_height_map + mean(column_height_map, 'all') + mean(row_height_map, 'all'))/4;
        
end

end

