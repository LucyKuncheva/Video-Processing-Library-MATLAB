function fox_plot_grid(r,c,t,axesHandle,fontName)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% r: number of rows
% c: number of columns
% t: an r-by-c cell array with text in the cells (optional)
%    (No provision is made to centre long text within the cell.)
% axesHandle: handle of the axes to plot the grid (optional)
% fontName: string (optional)
%==========================================================================
% Author: Lucy Kuncheva

if nargin >= 4
    if ~isempty(axesHandle), axes(axesHandle), end
else
    figure
end
[x,y] = meshgrid(0:c,0:r);
hold on, plot(x,y,'k-',x',y','k-')
axis equal off

if nargin >= 3
    if ~isempty(t) % plot text
        for i = 1:r
            for j = 1:c
                tx(i,j) = text(j-0.6,r-i+0.5,t{i,j});
            end
        end
    end
end

if nargin >= 5
    if ~isempty(fontName)
        set(tx,'FontName',fontName)
    end
end

