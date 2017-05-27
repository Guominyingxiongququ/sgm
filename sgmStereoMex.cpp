#include "mex.h"
#include <iostream>
#include <string>
#include "SgmStereo.h"
#include "ParameterSgmStereo.h"

using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  
  if (nrhs!=2 && nrhs!=3 && nrhs!=4 && nrhs!=5 && nrhs!=6 && nrhs!=7)
    mexErrMsgTxt("2-7 inputs required: I1 (left image), I2 (right image), [stereoslic_params,data,data_cap,smoothness,sgm] parameters");
  if (nlhs!=2 && nlhs!=4) 
    mexErrMsgTxt("2 or 4 outputs required: D1 (left disparities), D2 (right disparities), U1, U2");  
  if (!mxIsUint8(prhs[0]) || mxGetNumberOfDimensions(prhs[0])!=2)
    mexErrMsgTxt("Input I1 (left image) must be a uint8 image.");
  if (!mxIsUint8(prhs[1]) || mxGetNumberOfDimensions(prhs[1])!=2)
    mexErrMsgTxt("Input I2 (right image) must be a uint8 image.");
  
  // get input pointers
  unsigned char*   I1 = (unsigned char*)mxGetPr(prhs[0]);
  unsigned char*   I2 = (unsigned char*)mxGetPr(prhs[1]);
  const int32_t *dims = mxGetDimensions(prhs[0]);
  
  // width/height
  int w = dims[1];
  int h = dims[0];

  // create input images
  rev::Image<unsigned char> leftImage(w,h,1);
  rev::Image<unsigned char> rightImage(w,h,1);
  
  // copy input
  for (int u=0; u<w; u++) {
    for (int v=0; v<h; v++) {
      leftImage(u,v) = I1[u*h+v];
      rightImage(u,v) = I2[u*h+v];
    }
  }
  
  // get default parameters
  ParameterSgmStereo parameters;
  if (nrhs>=3) {
    bool stereoslic_params = (bool)*((double*)mxGetPr(prhs[2]));
    if (stereoslic_params)
        parameters.setDefaultStereoSlic();
  }
  
  // setup sgm
  SgmStereo sgmStereo;
  sgmStereo.setDisparityTotal(parameters.disparityTotal);
  sgmStereo.setOutputDisparityFactor(parameters.outputDisparityFactor);
  sgmStereo.setDataCostParameters(parameters.sadWeight, parameters.sobelCap, parameters.censusWinRad, parameters.censusWeight,
                                  parameters.aggWinRad, parameters.daisyNormType, parameters.daisyRad, parameters.daisyRadQ,
                                  parameters.daisyThQ, parameters.daisyHistQ, parameters.daisyWeight);
  sgmStereo.setDataCostCapParameters(parameters.sadCapValue, parameters.censusCapValue, parameters.daisyCapValue);
  sgmStereo.setSgmParameters(parameters.path8dir, parameters.consThresh);
  sgmStereo.setSmoothnessCostParameters(parameters.smoothPenSmall, parameters.smoothPenLarge);
  
  if (nrhs>=4) {
    double* p = (double*)mxGetPr(prhs[3]);
    sgmStereo.setDataCostParameters((double)p[0],(int)p[1],(int)p[2],(double)p[3],(int)p[4],(int)p[5],(int)p[6],(int)p[7],(int)p[8],(int)p[9],(double)p[10]);
  }

  if (nrhs>=5) {
    double* p = (double*)mxGetPr(prhs[4]);
    sgmStereo.setDataCostCapParameters((int)p[0],(int)p[1],(int)p[2]);
  }
  
  if (nrhs>=6) {
    double* p = (double*)mxGetPr(prhs[5]);
    sgmStereo.setSmoothnessCostParameters((int)p[0],(int)p[1]);
  }
  
  if (nrhs>=7) {
    double* p = (double*)mxGetPr(prhs[6]);
    sgmStereo.setSgmParameters((bool)p[0],(int)p[1]);
  }
  
  // calculate uncertainty maps?
  bool calculateUncertainties = false;
  if (nlhs==4)
    calculateUncertainties = true;
  
  // init output structures
  rev::Image<unsigned short> leftDisparityImage;
  rev::Image<unsigned short> rightDisparityImage;
  rev::Image<unsigned short> uncertaintyImage0;
  rev::Image<unsigned short> uncertaintyImage1;
  
  // run sgm
  // sgmStereo.plotParameters();
  sgmStereo.computeLeftRight(leftImage, rightImage, leftDisparityImage, rightDisparityImage,
                             uncertaintyImage0, uncertaintyImage1, calculateUncertainties);
  
  // create outputs
  plhs[0]     = mxCreateNumericArray(2,dims,mxDOUBLE_CLASS,mxREAL);
  double*   D1 = (double*)mxGetPr(plhs[0]);
  plhs[1]     = mxCreateNumericArray(2,dims,mxDOUBLE_CLASS,mxREAL);
  double*   D2 = (double*)mxGetPr(plhs[1]);
  
  // copy to output
  for (int u=0; u<w; u++) {
    for (int v=0; v<h; v++) {
      D1[u*h+v] = (double)leftDisparityImage(u,v)/(double)parameters.disparityTotal;
      D2[u*h+v] = (double)rightDisparityImage(u,v)/(double)parameters.disparityTotal;
      if (D1[u*h+v]<0.001) D1[u*h+v] = -1;
      if (D2[u*h+v]<0.001) D2[u*h+v] = -1;
    }
  }
  
  if (nlhs==4) {
    // create outputs
    plhs[2]     = mxCreateNumericArray(2,dims,mxDOUBLE_CLASS,mxREAL);
    double*   U1 = (double*)mxGetPr(plhs[2]);
    plhs[3]     = mxCreateNumericArray(2,dims,mxDOUBLE_CLASS,mxREAL);
    double*   U2 = (double*)mxGetPr(plhs[3]);

    // copy to output
    for (int u=0; u<w; u++) {
      for (int v=0; v<h; v++) {
        U1[u*h+v] = (double)uncertaintyImage0(u,v);
        U2[u*h+v] = (double)uncertaintyImage1(u,v);
      }
    }
  }
}
