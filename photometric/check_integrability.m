function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
[h,w,d] = size(normals);

p = zeros(size(normals));
q = zeros(size(normals));
SE = zeros([h,w]);

% ========================================================================
% Compute p and q, where
% p measures value of df / dx
p = normals(:,:,1) ./ normals(:,:,3);
q = normals(:,:,2) ./ normals(:,:,3);
% q measures value of df / dy

p(isnan(p)) = 0;
q(isnan(q)) = 0;

% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE
SE = zeros([h,w]);
dpdy = zeros([h,w]);
dqdx = zeros([h,w]);

p_y1 = p(:,1);
q_x1 = q(1,:);

%approximate derivatives
[~, dpdy] = gradient(p);
[dqdx, ~] = gradient(q);

%dpdy = diff([p_y1 p], 1, 2); 
%dqdx = diff([q_x1; q], 1, 1); 

%dpdy(:,2:end) = p(:,1:end-1) - p(:,2:end); 
%dqdx(2:end,:) = q(1:end-1,:) - q(2:end,:);
SE = (dpdy - dqdx).^2;
% ========================================================================
end

