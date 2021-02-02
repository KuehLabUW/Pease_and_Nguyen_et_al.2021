% script for running the 
indir = {'/data/phnguyen/Imaging/RawData/111617_EV_cMyc'};
basenames = {'EXP7'}
outdir = '/data/phnguyen/Imaging/RawData/111617_EV_cMyc-processed';

% generate parameter file for image procesing.
paramfile = 'params.mat';
makeparams(paramfile);
pipeline2(indir, basenames, outdir, paramfile);