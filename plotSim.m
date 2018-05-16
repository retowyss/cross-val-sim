function success = plotSim(rmses, modparams, folds)
% Prototype: plotSim( rmses, modparams, folds )
%
% Draw a line plot of the cross validation simulation.
% 
% [ in ]
% 
% @param {rmses}     RMSE generated by the crossSim function
% @param {modparams} matrix, set of parameters that were passed to modfit
% @param {folds}     matrix (k x 1) of integers 
%
% [ out ]
% 
% @return a sweet plot
%

% Graph Constants
% Font sizes
LEGEND_SIZE = 14;
LABEL_SIZE  = 18;
TITLE_SIZE  = 22;

% Colors
BACKGROUND_COLOR = [250,250,250]/255;
COLOR            = [1,1,1]*(1- 0.87);

% Color palette for lines, using material design colors
PALETTE = [[211,47,47];[48,63,159];[56,142,60];[230,74,25];[123,31,162]]/255;

% Drawing
% Initialize plot
p = plot(rmses);

% Label stuff
yLab       = ylabel("RMSE");
xLab       = xlabel("Folds [k]");
legendLab  = legend(arrayfun(@(x) {strcat('Model-', num2str(x))}, modparams));
graphTitle = title('Cross Validation Simulation');

% Adjust font sizes
set(xLab, "fontsize", LABEL_SIZE);
set(yLab, "fontsize", LABEL_SIZE);
set(legendLab, "fontsize", LEGEND_SIZE); 
set(graphTitle, "fontsize", TITLE_SIZE);

% Set ticks
xtick = 1:length(folds);
set(gca,'xtick',xtick);
set(gca, 'xticklabel', folds'); 

% Tweak Look
legend boxoff;
set(legendLab, "location", "northeastoutside");
set(p, "linewidth", 3.1415926)


% Give it a dark Material lookfor
set(gcf,'Color', BACKGROUND_COLOR);
set(xLab, {'Color'}, COLOR);
set(yLab, {'Color'}, COLOR);

if length(p) <= length(PALETTE)
  for i = 1:length(p) 
    set(p(i),"color", PALETTE(i,:)); 
  end 
endif

endfunction