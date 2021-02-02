% script for running the 
indir = {'/data/phnguyen/Imaging/RawData/080917_p21_EV_cMyc'};
basenames = {'LatestExp'}
outdir = '/data/phnguyen/Imaging/RawData/080917-processed';

% generate parameter file for image procesing.
paramfile = 'params.mat';
makeparams(paramfile);
pipeline2(indir, basenames, outdir, paramfile);