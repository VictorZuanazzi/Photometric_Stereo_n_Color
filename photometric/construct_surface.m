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
        for hi = 2:h
            height_map(hi, 1) = height_map(hi-1, 1)+ q(hi, 1);
        end
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value  
        for hi = 1:h
            for wi = 2:w
                height_map(hi, wi) = height_map(hi, wi-1) + p(hi, wi);
            end
        end
                    
    case 'row'
        % top left corner of height_map is zero
        % for each pixel in the top row of height_map
        %   height_value = previous_height_value + corresponding_p_value
        for wi = 2:w
            height_map(1, wi) = height_map(1, wi-1)+p(1, wi);
        end
        
        % for each columns
        %   for each element of the columns except for top one
        %       height_value = previous_height_value + corresponding_q_value
        for wi = 1:w
            for hi = 2:h
                height_map(hi, wi) = height_map(hi-1, wi)+q(hi, wi);
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
        epsilon = 0.0001;
        row_height_map = construct_surface( p, q, 'row' );
        min_v = min(row_height_map, 'all');
        row_height_map = row_height_map + min_v + epsilon;
        
        %height_map by row
        column_height_map = construct_surface( p, q, 'column' );
        min_v = min(column_height_map, 'all');
        column_height_map = column_height_map + min_v + epsilon;
        
        %harmonic average of the two
        height_map = (row_height_map .* column_height_map).^(1/2);
end

end

