function map = stoplight(m)
%STOPLIGHT    Stoplight color map
%   STOPLIGHT(M) returns an M-by-3 matrix containing a stoplight colormap.
%   STOPLIGHT, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB uses the length of the
%   default colormap.
%
%   The STOPLIGHT colormap varies the hue component of the hue-saturation-
%   value color model as well as the value component to replicate the 
%   color range displayed by a stoplight. The colors between with red, pass
%   through orange, yellow, and end with green. 
%
%   For example, to reset the colormap of the current figure:
%
%             colormap(stoplight)
%
%   See also HSV, GRAY, HOT, COOL, BONE, COPPER, PINK, FLAG, PRISM, JET,
%   COLORMAP, RGBPLOT, HSV2RGB, RGB2HSV.

if nargin < 1
    f = get(groot,'CurrentFigure');
    if isempty(f)
        m = size(get(groot,'DefaultFigureColormap'),1);
    else
        m = size(f.Colormap,1);
    end
end

hue = 0.3/2*( 1 + cos([0:m-1]*pi/m - pi))';
sat = ones(size(hue));
val = linspace(1, 0.7, m)';
if isempty(hue)
    map = zeros(0,3);
else
    map = hsv2rgb([hue, sat, val]);
end
