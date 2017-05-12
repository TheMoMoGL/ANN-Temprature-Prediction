function [variable] = loadVariable(fileName)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loads a single variable from file
%
% Inputs: fileName -> Name of the file to be loaded
%
% Outputs: variable -> Array with variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file = load(fileName);
variableNames = fieldnames(file);

if numel(variableNames) == 1 % If file exists, load file into variable
    variable = file.(variableNames{1});
else
    error('Selected file could not be loaded') % If not, print error to user
end

end