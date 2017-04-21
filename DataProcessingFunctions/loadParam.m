%%% Function to load parameters from .mat file %%%
%%% Places each year separately into matrices %%%


function [param2013, param2014, param2015, param2016] = loadParam()

load Sunprog2013
load TempProg2013
load TempReal2013
load Time2013
load WindProg2013

load Sunprog2014
load TempProg2014
load TempReal2014
load Time2014
load WindProg2014

load Sunprog2015
load TempProg2015
load TempReal2015
load Time2015
load WindProg2015

load Sunprog2016
load TempProg2016
load TempReal2016
load Time2016
load WindProg2016

param2013 = [TempReal2013 TempProg2013 SunProg2013 WindProg2013];
param2014 = [TempReal2014 TempProg2014 SunProg2014 WindProg2014];
param2015 = [TempReal2015 TempProg2015 SunProg2015 WindProg2015];
param2016 = [TempReal2016 TempProg2016 SunProg2016 WindProg2016];

end
