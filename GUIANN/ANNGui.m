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

% Last Modified by GUIDE v2.5 09-May-2017 11:00:11

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
cla(handles.axes5)
cla(handles.axes2)
clearvars daysBefore;
clearvars hoursbefore;
clearvars starthidden;
clearvars endHidden;
clearvars learningRate;
clearvars NumbHiddLay;
clearvars K_factor;
clearvars Start_month;
clearvars End_month;
clearvars bestOutputValid;
clearvars bestTargetValid;
clearvars bestHiddNeurons;
clearvars time;
clearvars dt;
clearvars progtemp
clearvars endReport;
clearvars samples;
clearvars progTemp;
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
daysBefore=str2num(get(handles.DaysbeforeINP,'string'));
hoursbefore=str2num(get(handles.HoursBeforeINP,'string'));
starthidden=str2num(get(handles.StartNodeINP,'string'));
endHidden=str2num(get(handles.EndNodeINP,'string'));
learningRate=str2num(get(handles.LearningRateINP,'string'));
NumbHiddLay=str2num(get(handles.HiddenLayersINP,'string'));
time =str2num(get(handles.HourlyforecastINP,'string'));
K_factor=str2num(get(handles.KfactorINP,'string'));
Start_month=str2num(get(handles.StartSeasonINP,'string'));
End_month=str2num(get(handles.endSeasonINP,'string'));
run('ANNmain.m');

progEnd = length(bestOutputValid);
[m,~] = size(bestOutputValid);
progtemp = progTemp(1:progEnd)';
dt = 1:1:m;
% figure('units','normalized','outerposition',[0 0 1 1])
axes(handles.axes5);
plot(dt, bestOutputValid(:,1))
hold on
plot (dt, bestTargetValid(:,1))
hold on
plot (dt, progtemp, 'g')
legend('Temperature prognosis', 'Measured temperature', 'SMHI prognosis')
% axes(handles.axes2); %
    
% subplot(2,2,1)       % add first plot in 2 x 2 grid
stem(handles.axes2,endReport(:,2),endReport(:,5))           % stem plot
axis(handles.axes2,[1 endHidden 0 samples])    
set(handles.figure1, 'pointer', 'arrow')
% set(gcf,'Pointer','arrow');
guidata(hObject,handles)



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
clearvars daysBefore;
clearvars hoursbefore;
clearvars starthidden;
clearvars endHidden;
clearvars learningRate;
clearvars NumbHiddLay;
clearvars K_factor;
clearvars Start_month;
clearvars End_month;
clearvars bestOutputValid;
clearvars bestTargetValid;
clearvars bestHiddNeurons;
clearvars time;
clearvars dt;
clearvars progtemp
clearvars endReport;
clearvars samples;
clearvars progTemp;
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
