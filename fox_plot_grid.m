function fox_plot_grid(r,c,t,axesHandle,fontName)
%=======================================================================
%fox_plot_grid Plot a cell grid with short text in the middle of each 
%cell
%   fox_plot_grid(r,c,t,axesHandle,fontName) 
%
%   Input -----
%      'r': number of rows
%      'c': number of columns
%      't': an r-by-c cell array with text in the cells (optional)
%           (No provision is made to centre long text within the cell.)
%      'axesHandle': handle of the axes to plot the grid (optional)
%      'fontName': string (optional)
%
%   Example 1:
%      fox_plot_grid(5,4)
%
%   Example 2:
%      t = {'sun','rain','hale';'dry','cloudy','hurricane'};
%      fox_plot_grid(2,3,t)
%
%   Example 3:
%      t = {'sun','rain','hale';'dry','cloudy','hurricane'};
%      figure, fox_plot_grid(2,3,t,[],'Calibri')
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

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

