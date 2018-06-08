function x = fox_get_features(im,fstr,blocks,bins)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 01.11.2017 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% im: RGB image                  = input image
% fstr: RGB, HSV, CHR, OHT, H    = feature string
% blocks: 9, 4, 1                = number of blocks
% bins: e.g., 8, 16, 32 (or any) = number of bins for histogram features
%
% Output
%
% x: vector-row with the extracted features
%==========================================================================
% Author: Lucy Kuncheva

%#ok<*AGROW>

blocks = round(sqrt(blocks));
ims = size(im);
ims = ims(1:2);

ro = round(linspace(1,ims(1),blocks+1));
co = round(linspace(1,ims(2),blocks+1));
x = [];
for si = 1:blocks
    endpixelr = ro(si+1)-1;
    if si == blocks, endpixelr = ro(si+1); end
    for sj = 1:blocks
        endpixelc = co(sj+1)-1;
        if sj == blocks, endpixelc = co(sj+1); end
        partFrame = im(ro(si):endpixelr,co(sj):endpixelc,:);
        if strcmpi(fstr,'H')
            x = [x colour_features_histogram(partFrame,bins)];
        else
            x = [x colour_features_mean(partFrame,fstr)];
        end
    end
end
end

% *************************************************************************
function x = colour_features_mean(im,colour_space)

im = double(im);
r = im(:,:,1); g = im(:,:,2); b = im(:,:,3);
cols = [r(:) g(:) b(:)];
if nargin == 1
    colour_space = 'RGB'; % default
end

switch upper(colour_space)
    case 'RGB' %-----------------------------------------------------------
        x = [mean(cols) std(cols)];
    case 'HSV' %-----------------------------------------------------------
        hsv = rgb2hsv(cols/255);
        x = [mean(hsv) std(hsv)];
    case 'CHR' %-----------------------------------------------------------
        % chrominance
        d = sqrt(r.^2 + g.^2 + b.^2);
        if d
            c1 = r./d; c2 = g./d;
            x = [mean([c1(:) c2(:)],1) std([c1(:) c2(:)],1)];
        else
            x = [0 0 0 0];
        end
    case 'OHT' %-----------------------------------------------------------
        % Ohta 1980 space
        i1 = (r + g + b) / 3;
        i2 = r - b;
        i3 = (2*g - r - b) / 2;
        cols2 = [i1(:) i2(:) i3(:)];
        x = [mean(cols2) std(cols2)];
end
end

function x = colour_features_histogram(img,bins)
hsvim = rgb2hsv(double(img));

h1 = hsvim(:,:,1); h2 = hsvim(:,:,2); h3 = hsvim(:,:,3);
hsv = double([h1(:) h2(:) h3(:)]);

X = find_bins(bins,0,1);
x = hist(hsv(:,1),X);
end

function B = find_bins(bins,x1,x2)
B = linspace(x1,x2,bins + 1); B = B - (B(2)-B(1)) / 2; B(1) = [];
end
