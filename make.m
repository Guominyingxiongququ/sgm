clear all; close all; dbstop error;

cxxflags = 'CXXFLAGS=\$CXXFLAGS -msse3 -fPIC';
%cxxflags = 'CXXFLAGS=\$CXXFLAGS -msse3 -fPIC';
%cxxflags = 'CXXFLAGS=\$CXXFLAGS -msse4.2 -fPIC -DMM_POPCNT';

mex('sgmStereoMex.cpp','src/SgmStereo.cpp','src/Image.cpp','src/CappedSobelFilter.cpp', ...
    'src/CensusTransform.cpp','src/GCCostCalculator.cpp','src/DaisyDescriptor.cpp','-Isrc',...
    '-Iinclude','-Ipng/libpng',cxxflags,'-lpng','lib/libdaisy.a');

%mex('removeSmallSegmentsMex.cpp');

disp('done!');
