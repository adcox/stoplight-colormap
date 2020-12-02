function map = stoplight(m, shape)
%STOPLIGHT    Stoplight color map
%   STOPLIGHT(M) returns an M-by-3 matrix containing a stoplight colormap.
%   STOPLIGHT, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB uses the length of the
%   default colormap.
%
%   The STOPLIGHT colormap varies the hue component of the hue-saturation-
%   value color model as well as the value component to replicate the 
%   color range displayed by a stoplight. The colors begin with red, pass
%   through orange, yellow, and end with green.
%
%   STOPLIGHT(M, SHAPE) returns an M-by-3 matrix containing stoplight
%   colors with the hue value defined by the shape argument. Valid shapes
%   are as follows:
%
%       'cos'   -   [default] Hue varies along a cosine curve; red and
%                   green dominate this colormap
%       'atan'  -   Hue varies along a tangent curve; orange and yellow
%                   dominate this colormap
%       'linear'-   Hue varies along a linear curve; lots of red and green
%                   with a fair amount of orange.
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

if(nargin < 2)
    shape = 'cos';
end

switch lower(shape)
    case 'cos'
        hue = 0.3 * ( 1 + cos([0:m-1]*pi/m - pi))'/2;
    case 'tan'
        hue = 0.3 * (tan(3*pi/8) + tan([0:m-1]*3*pi/4/m - 3*pi/8))'/(2*tan(3*pi/8));
    case 'linear'
        hue = 0.3 * linspace(0, 1, m)';
    otherwise
        error('Unrecognized hue shape: %s', shape);
end

sat = ones(size(hue));
val = linspace(1, 0.7, m)';
if isempty(hue)
    map = zeros(0,3);
else
    map = hsv2rgb([hue, sat, val]);
end
