function htmlLink = texifyFormula(str, fname, directory)
%% Create a png image of a compiled single line latex mathematical formula
%
%% Inputs
%
% str      -   a valid latex formula, see example
%             (we surround it with '$' signs automatically if you don't)
%
% fname    -   a .png image of the compiled latex formula will be saved
%              with this filename. Don't include the full path, just the name.
%
% directory - [default = pwd] the image will be saved to this directory.
%
%% Output
%
% Returns an html code needed to embed the image assuming the html file
% will live in the same folder as the image, e.g. <img src="formula.png">
%
%%
% Tested on Matlab 2010a (win32) and might not work on earlier versions.
%
%%
%PMTKneedsMatlab
%
%% Example
%
% str = '\int binom(x|n,\theta) betadist(\theta|a,b)d\theta';
% fname = 'formula';
% texifyFormula(str, fname);
%
%%

if nargin < 3
    directory = pwd;
end


if ~(str(1) == '$')
    str = ['$', str];
end

if ~(str(end) == '$')
    str = [str, '$'];
end

if ~endswith(fname, '.png')
    fname = [fname, '.png'];
end


txt = {
    '%%'
    '%'
    sprintf('%% %s', str);
    '%'
    '%%'
    };

writeText(txt, fullfile(directory, 'texifySrc.m'));
opts.outputDir = directory;
opts.imageFormat = 'png';
opts.evalCode = false;
publish(fullfile(directory, 'texifySrc.m'), opts);
list = filelist(directory, 'texifySrc*.png');
delete(fullfile(directory, 'texifySrc.m'));
delete(fullfile(directory, 'texifySrc.html'));
if exist(fname, 'file')
    delete(fname);
end
system(sprintf('rename %s %s', list{1}, fname));
htmlLink = sprintf('<img src="%s">', fname);

end