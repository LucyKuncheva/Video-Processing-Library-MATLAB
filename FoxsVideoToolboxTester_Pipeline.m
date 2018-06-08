% Fox's Video Toolbox Tester
%#ok<*SAGROW>
warning off

clear, clc, close all
% Video #v21 from the VSUMM project 

% Feature space: H histogram, 16 blocks.
% Distance: Minkowski (same as L1 norm, Manhattan).
% Threshold for frame similarity: 0.5.
% Pairing method: Greedy

% Upload candidate summary ------------------------------------------------
t = dir('KeyframeSummaries/OV_v21/*.jpeg');
for i = 1:numel(t)
    s1 = strrep(t(i).name,'Frame','');
    s2 = strrep(s1,'.jpeg','');
    fn(i) = str2double(s2);
end
fn = sort(fn);
for i = 1:numel(t)
    CS{i} = imread(['KeyframeSummaries/OV_v21/Frame' num2str(fn(i)) ...
        '.jpeg']);
end

% Upload ground truth -----------------------------------------------------
t = dir('KeyframeSummaries/user1/*.jpeg');
fn = [];
for i = 1:numel(t)
    s1 = strrep(t(i).name,'Frame','');
    s2 = strrep(s1,'.jpeg','');
    fn(i) = str2double(s2);
end
fn = sort(fn);
for i = 1:numel(t)
    GT{i} = imread(['KeyframeSummaries/user1/Frame' num2str(fn(i)) ...
        '.jpeg']);
end

% Extract histogram features ----------------------------------------------
featureString = 'H'; % feature space
blocks = 1; % no split
bins = 16; % not a histogram

A = [];
for i = 1:numel(CS)
    A(i,:) = fox_get_features(CS{i}, featureString, blocks, bins);  
end

B = [];
for i = 1:numel(GT)
    B(i,:) = fox_get_features(GT{i}, featureString, blocks, bins); 
end

% Calculate distance matrix -----------------------------------------------
A = A./repmat(sum(A,2),1,16); % scale to sum 1
B = B./repmat(sum(B,2),1,16); % scale to sum 1

M = pdist2(A,B,'minkowski',1);
threshold = 0.5;

% Calculate F-measure between summaries -----------------------------------
[F,nm,mcs,mgt] = fox_pairing_frames(M,threshold,2); % Greedy matching

fprintf('F-value = %.4f\nNumber of matches = %i\n',F,nm)

% Visualise the matches ---------------------------------------------------
grey = [1 1 1]*0.8; % grey
mcol = [0 0 1]*0.8; % "match" colour
coGT = [repmat(mcol,nm,1);repmat(grey,numel(GT)-nm,1)]; % rim colour GT
coCS = [repmat(mcol,nm,1);repmat(grey,numel(CS)-nm,1)]; % rim colour CS

% Rearrange the keyframes so that the matches are at the front
rCS = CS([mcs;setxor(1:numel(CS),mcs)]); 
rGT = GT([mgt;setxor(1:numel(GT),mgt)]); 

fox_montage(rGT,[1 numel(GT)],coGT,0.15)
fox_montage(rCS,[1 numel(CS)],coCS,0.15)



