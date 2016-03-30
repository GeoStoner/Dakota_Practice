%% Trying to write a basic model for Dakota to test. Modified code from G. 
% Tucker 
% written by R. Stoner, for Modeling class, March 2016

 import sys
 from subprocess import call
 import numpy as np
% ^ Only relevant for python


% Set the file names to use for the input file and template input file. The template
% input file is a text file we create that contains the string "{coefficient}". The
% actual input file, 'my_inputs.txt', will be created automatically by Dakota, which will
% replace "{coefficient}" with a number.
input_file_template = 'my_inputs_template.mat.txt'
input_file = 'my_inputs.txt'

% Run Dakota's "dprepro" (preprocessor) program. This will make a new copy of
% 'my_inputs_template.txt' but replace the string that reads "{coefficient}" with an
% actual numerical value (or rather, a string representing a numeric value). It will then
% save the file with the name 'my_inputs.txt'. The actual value will be obtained from
% a third, Dakota-created file called 'params.in' (this same name is also passed in as
% an argument, and because it is the first argument, it is in sys.argv[1])
call(['dprepro', sys.argv[1], input_file_template, input_file])

% Get the input value for the model
infile = open(input_file)
coef = float( infile.readline() )
infile.close()

% Original .py code: print 'Running with coefficient value', coef
% Not needed

# The model has a domain of "x" values that range from 1 to 10
x = 0:1.0:11.0;

% Let's say we have some data (here completely made up: we "know" that the actual 
% correct coefficient value is 10.4)
y_data = 10.4 * sqrt(x);

# Now run the model, which in this case is simple: y = coef sqrt(x)
y_model = coef * sqrt(x);

% Find the root-mean-square misfit between model and data
rms_error = sqrt( sum( (y_model - y_data)^2 ) )

% print 'RMS error with coef', coef, 'is', rms_error
% printing different for matlab file

% Write the RMS error to a file
outfile = open(sys.argv[2], 'w')
outfile.write(str(rms_error))
outfile.close()
