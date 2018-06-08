% Fox's Video Toolbox Tester

clear, clc, close all

methodNames = {'1. Naive', '2. Greedy','3. Hungarian', '4. Mahmoud',...
    '5. Kannappan', '6. Maximal'};

% Create a match matrix ---------------------------------------------------

cs = rand(11,2); % candidate summary
gt = rand(10,2); % ground truth


M = pdist2(cs,gt); % distance matrix


% Calculate match ---------------------------------------------------------
[F,number_of_matches] = deal(zeros(1,6));
thr = 0.3; % threshold
figure
for i = 1:6
    [F(i),number_of_matches(i),mcs,mgt] = fox_pairing_frames(M,thr,i);
    subplot(2,3,i)
    hold on, axis([0 1 0 1]), axis square off
    plot(cs(:,1),cs(:,2),'k.','markersize',15)
    plot(gt(:,1),gt(:,2),'rx','markersize',7,'linewidth',1.5)
    for j = 1:number_of_matches(i)
        plot([cs(mcs(j),1) gt(mgt(j),1)],[cs(mcs(j),2) gt(mgt(j),2)],...
            'b.-') % connect matches
        plot(gt(mgt(j),1), gt(mgt(j),2),...
            'bo','markersize',10) % connect matches        
    end
    title([methodNames{i} ' (' num2str(number_of_matches(i)) ')'])
end