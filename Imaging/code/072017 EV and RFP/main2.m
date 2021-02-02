% script for running the 
indir = {'/data/phnguyen/Imaging/RawData/EV RFP 1-1 and 1-10 072017'};
basenames = {'Exp2','Exp3'}
outdir = '/data/phnguyen/Imaging/RawData/072017 - processed';

% generate parameter file for image procesing.
paramfile = 'params.mat';
makeparams(paramfile);
pipeline2(indir, basenames, outdir, paramfile);