function varargout = ANNGui(varargin)
%ANNGUI MATLAB code file for ANNGui.fig
%      ANNGUI, by itself, creates a new ANNGUI or raises the existing
%      singleton*.
%
%      H = ANNGUI returns the handle to a new ANNGUI or the handle to
%      the existing singleton*.
%
%      ANNGUI('Property','Value',...) creates a new ANNGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ANNGui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ANNGUI('CALLBACK') and ANNGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ANNGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ANNGui

% Last Modified by GUIDE v2.5 11-May-2017 07:54:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ANNGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ANNGui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ANNGui is made visible.
function ANNGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ANNGui
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ANNGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ANNGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RunProg.
function RunProg_Callback(hObject, eventdata, handles)
% hObject    handle to RunProg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
set(handles.figure1, 'pointer', 'watch')
pause(0.01);
clearbutton_Callback(hObject, eventdata, handles);
pause(0.01);
global daysBefore;
global hoursbefore;
global starthidden;
global endHidden;
global learningRate;
global NumbHiddLay;
global K_factor;
global Start_month;
global End_month;
global bestOutputValid;
global bestTargetValid;
global bestHiddNeurons;
global time;
global dt;
global progtemp
global endReport;
global samples;
global progTemp;
global percent;
daysBefore = str2double(get(handles.DaysbeforeINP,'string'));
hoursbefore = str2double(get(handles.HoursBeforeINP,'string'));
starthidden = str2double(get(handles.StartNodeINP,'string'));
endHidden = str2double(get(handles.EndNodeINP,'string'));
learningRate = str2double(get(handles.LearningRateINP,'string'));
NumbHiddLay = str2double(get(handles.HiddenLayersINP,'string'));
time = str2double(get(handles.HourlyforecastINP,'string'));
K_factor = str2double(get(handles.KfactorINP,'string'));
Start_month = str2double(get(handles.StartSeasonINP,'string'));
End_month = str2double(get(handles.endSeasonINP,'string'));
run('ANNmain.m');
[maxGood, I] = max(endReport(:,5));
maxBad = endReport(I,6);
percent = (maxGood/(maxBad + maxGood))*100;
percent1 = sprintf('Percent: %3f', percent);
set(handles.PercentCorrect, 'String', percent1);
colnames = {'Inputs', 'Hidden inputs', 'Good', 'Bad', 'RMSE', 'MAPE', 'Correlation'};
set(handles.Table,'data',[endReport(I,1), endReport(I,2), maxGood, maxBad, endReport(I,7), endReport(I,8), endReport(I,9)],'ColumnName',colnames);


% progEnd = length(bestOutputValid);
% [m,~] = size(bestOutputValid);
% progtemp = progTemp(1:progEnd)';
% dt = 1:1:m;
% axes(handles.axes5);
% plot(dt, bestOutputValid(:,1))
% hold on
% plot (dt, bestTargetValid(:,1))
% hold on
% plot (dt, progtemp, 'g')
% legend('Temperature prognosis', 'Measured temperature', 'SMHI prognosis')
stem(handles.axes2,endReport(:,2),endReport(:,5)) % stem plot
axis(handles.axes2,[1 endHidden 0 samples])    
% set(handles.figure1, 'pointer', 'arrow')
% % set(gcf,'Pointer','arrow');
% guidata(hObject,handles)


outputDayPlot = bestOutputValid(1:24, 1);
targetDayPlot = bestTargetValid(1:24,1);
compareDayPlot = progTemp(1:24);
dp = 1:1:24;
axes(handles.axes5);
plot(dp, outputDayPlot)
hold on
plot(dp, targetDayPlot)
hold on
plot(dp, compareDayPlot)
legend('Temperature prognosis', 'Measured temperature', 'SMHI prognosis')
set(handles.figure1, 'pointer', 'arrow')
guidata(hObject, handles)




function LearningRateINP_Callback(hObject, eventdata, handles)
% hObject    handle to LearningRateINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LearningRateINP as text
%        str2double(get(hObject,'String')) returns contents of LearningRateINP as a double


% --- Executes during object creation, after setting all properties.
function LearningRateINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LearningRateINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HiddenLayersINP_Callback(hObject, eventdata, handles)
% hObject    handle to HiddenLayersINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HiddenLayersINP as text
%        str2double(get(hObject,'String')) returns contents of HiddenLayersINP as a double


% --- Executes during object creation, after setting all properties.
function HiddenLayersINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HiddenLayersINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KfactorINP_Callback(hObject, eventdata, handles)
% hObject    handle to KfactorINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KfactorINP as text
%        str2double(get(hObject,'String')) returns contents of KfactorINP as a double


% --- Executes during object creation, after setting all properties.
function KfactorINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KfactorINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StartNodeINP_Callback(hObject, eventdata, handles)
% hObject    handle to StartNodeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartNodeINP as text
%        str2double(get(hObject,'String')) returns contents of StartNodeINP as a double


% --- Executes during object creation, after setting all properties.
function StartNodeINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartNodeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndNodeINP_Callback(hObject, eventdata, handles)
% hObject    handle to EndNodeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndNodeINP as text
%        str2double(get(hObject,'String')) returns contents of EndNodeINP as a double


% --- Executes during object creation, after setting all properties.
function EndNodeINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndNodeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StartSeasonINP_Callback(hObject, eventdata, handles)
% hObject    handle to StartSeasonINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartSeasonINP as text
%        str2double(get(hObject,'String')) returns contents of StartSeasonINP as a double


% --- Executes during object creation, after setting all properties.
function StartSeasonINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartSeasonINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endSeasonINP_Callback(hObject, eventdata, handles)
% hObject    handle to endSeasonINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endSeasonINP as text
%        str2double(get(hObject,'String')) returns contents of endSeasonINP as a double


% --- Executes during object creation, after setting all properties.
function endSeasonINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endSeasonINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Hoursbefore_Callback(hObject, eventdata, handles)
% hObject    handle to Hoursbefore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Hoursbefore as text
%        str2double(get(hObject,'String')) returns contents of Hoursbefore as a double


% --- Executes during object creation, after setting all properties.
function Hoursbefore_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Hoursbefore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HourlyforecastINP_Callback(hObject, eventdata, handles)
% hObject    handle to HourlyforecastINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HourlyforecastINP as text
%        str2double(get(hObject,'String')) returns contents of HourlyforecastINP as a double


% --- Executes during object creation, after setting all properties.
function HourlyforecastINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HourlyforecastINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HoursBeforeINP_Callback(hObject, eventdata, handles)
% hObject    handle to HoursBeforeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HoursBeforeINP as text
%        str2double(get(hObject,'String')) returns contents of HoursBeforeINP as a double


% --- Executes during object creation, after setting all properties.
function HoursBeforeINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HoursBeforeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DaysbeforeINP_Callback(hObject, eventdata, handles)
% hObject    handle to DaysbeforeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DaysbeforeINP as text
%        str2double(get(hObject,'String')) returns contents of DaysbeforeINP as a double


% --- Executes during object creation, after setting all properties.
function DaysbeforeINP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DaysbeforeINP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearbutton.
function clearbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clearbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
cla(handles.axes5)
cla(handles.axes2)
set(handles.PercentCorrect, 'string', 'Percent: ')
set(handles.Table,'data',cell(size(get(handles.Table,'data'))))
pause(0.01);
clear global daysBefore;
clear global hoursbefore;
clear global starthidden;
clear global endHidden;
clear global learningRate;
clear global NumbHiddLay;
clear global K_factor;
clear global Start_month;
clear global End_month;
clear global bestOutputValid;
clear global bestTargetValid;
clear global bestHiddNeurons;
clear global time;
clear global dt;
clear global progtemp;
clear global endReport;
clear global samples;
clear global progTemp;
clear global percent;
guidata(hObject,handles)


% --- Executes on button press in Details.
function Details_Callback(hObject, eventdata, handles)
% hObject    handle to Details (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
global daysBefore;
global hoursbefore;
global starthidden;
global endHidden;
global learningRate;
global NumbHiddLay;
global K_factor;
global Start_month;
global End_month;
global bestOutputValid;
global bestTargetValid;
global bestHiddNeurons;
global time;
global dt;
global progtemp
global endReport;
global samples;
global progTemp;
bestrun = EndReportcompilation(endReport, samples, endHidden, bestOutputValid, bestTargetValid, bestHiddNeurons, progTemp); %endReport compilation in progess
 guidata(hObject,handles)



function percent_Callback(hObject, eventdata, handles)
% hObject    handle to percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percent as text
%        str2double(get(hObject,'String')) returns contents of percent as a double


% --- Executes during object creation, after setting all properties.
function percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
handles=guidata(hObject);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
handles=guidata(hObject);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

guidata(hObject,handles)


% --- Executes when entered data in editable cell(s) in Table.
function Table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in Table.
function Table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
