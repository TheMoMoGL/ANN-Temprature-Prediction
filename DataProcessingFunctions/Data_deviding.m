function [Data14,Data15,Data16 ] = Data_deviding( start_season,end_season )

load('Wind16.mat')
load('Wind15.mat')
load('Wind14.mat')
load('Sun16.mat')
load('Sun15.mat')
load('Sun14.mat')
load('Rtemp16.mat')
load('Rtemp15.mat')
load('Rtemp14.mat')
load('Ptemp16.mat')
load('Ptemp15.mat')
load('Ptemp14.mat')
load('Datetime16.mat')
load('Datetime15.mat')
load('Datetime14.mat')
%%%%%%%%%%%%%%%%%% seasongs deviding %%%%%%%%%%%%%%%%%%
% seasong 1 -> Jan-Mars
% seasong 2 -> Spril-Jun
% seasong 3 -> juli-Sep
% seasong 4 -> Oct-Dec

%%%%%%%%%%%%%%%% Get the right index for end  Start %%%%%%%%%%
if start_season==1 
    start_season=1;
elseif start_season==2
    start_season=8637;
    
elseif start_season==3
    start_season=17273;
else 
    start_season=26205;   
end 
    
%%%%%%%%%%%%%%%% Get the right index for the end  %%%%%%%%%%
if end_season==1 
    end_season=8636;
elseif end_season==2
    end_season=17372;
    
elseif end_season==3
    end_season=26204;
else 
   end_season=35040;   
end 
%%%%%%%%%%%%%%% Get the right data for each data set 
% validationData = [Pwind, Psun, Ptemp, Rtemp];
Data14(:,:,:,:)=[Wind14(start_season:end_season,:) Sun14(start_season:end_season,:) Ptemp14(start_season:end_season,:)   Rtemp14(start_season:end_season,:)];
Data15(:,:,:,:)=[Wind15(start_season:end_season,:) Sun15(start_season:end_season,:) Ptemp15(start_season:end_season,:)   Rtemp15(start_season:end_season,:)];
Data16(:,:,:,:)=[Wind16(start_season:end_season,:) Sun16(start_season:end_season,:) Ptemp16(start_season:end_season,:)   Rtemp16(start_season:end_season,:)];



end

