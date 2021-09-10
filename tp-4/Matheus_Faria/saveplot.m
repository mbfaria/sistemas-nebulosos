function [] = saveplot(h ,filename)
%SAVEPLOT Summary of this function goes here
%   Detailed explanation goes here

fname = '.\';
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(h, fullfile(fname, filename),'-dpdf','-r0');

end
