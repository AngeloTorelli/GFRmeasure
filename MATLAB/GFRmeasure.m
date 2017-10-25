function varargout = GFRmeasure(varargin)
% GFRMEASURE MATLAB code for GFRmeasure.fig
%      GFRMEASURE, by itself, creates a new GFRMEASURE or raises the existing
%      singleton*.
%
%      H = GFRMEASURE returns the handle to a new GFRMEASURE or the handle to
%      the existing singleton*.
%
%      GFRMEASURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GFRMEASURE.M with the given input arguments.
%
%      GFRMEASURE('Property','Value',...) creates a new GFRMEASURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GFRmeasure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GFRmeasure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GFRmeasure

% Last Modified by GUIDE v2.5 03-Apr-2017 09:55:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GFRmeasure_OpeningFcn, ...
    'gui_OutputFcn',  @GFRmeasure_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
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


% --- Executes just before GFRmeasure is made visible.
function GFRmeasure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GFRmeasure (see VARARGIN)

% Choose default command line output for GFRmeasure
handles.output = hObject;

handles.compartments = 3;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GFRmeasure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GFRmeasure_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1,'Value', 0);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    npath   = uigetdir(handles.filename,'Please select the folder to save the results');

    if isequal(npath,0)
        disp('User selected Cancel')

    else
        if ismac
            separator = '/';
        elseif isunix
            separator = '/';
        elseif ispc
            separator = '\';
        else
            disp('Platform not supported')
        end

        set(handles.pushbutton2,'Value', 0);
        fig   = gcf;
        idx   = strfind(handles.filename, '.');
        idx2  = strfind(handles.filename, separator);
        if isdeployed
            disp([npath separator handles.filename(idx2(end)+1:idx(end)-1) '_result.jpg'])
            print  (fig, [npath separator handles.filename(idx2(end)+1:idx(end)-1) '_result.jpg'],'-djpeg')
            sttt = sprintf('Result is saved in : %s', [npath separator handles.filename '_result.jpg']);
        else
            disp([npath separator handles.filename '_result.jpg'])
            print  (fig, [npath separator handles.filename '_result.jpg'],'-djpeg')
            sttt = sprintf('Result is saved in : %s', [npath separator handles.filename '_result.jpg']);
        end
        
        set(handles.edit5, 'String', sttt);
        
        %% Write colony features to text file
        if isdeployed
            fileID = fopen([npath separator  handles.filename(idx2(end)+1:idx(end)-1) '_Summary.txt'],'wt');
        else
            fileID = fopen([npath separator  handles.filename '_Summary.txt'],'wt');
        end
        for i = 1:size(handles.string,2)
            if ~isempty(handles.string{i})
                fprintf(fileID,handles.string{i});
            end
        end
        fclose(fileID);

    end
catch ME
    waitfor(errordlg(getReport(ME,'extended','hyperlinks','off'),'Error'));
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton3,'Value', 0);
[FileName,PathName,~] = uigetfile({'*.xlsx;*.csv','Exel-Sheet(*.xlsx,*.csv)'},pwd);
[~,~,ext]   = fileparts(FileName);

offset = str2double(get(handles.edit2, 'String'));
switch get(handles.popupmenu3,'Value')   
    case 1
        opt_start_pt = [str2double(get(handles.editA, 'String')) ...
                        str2double(get(handles.editB, 'String')) ...
                        str2double(get(handles.editC, 'String')) ...
                        str2double(get(handles.editD, 'String')) ...
                        str2double(get(handles.editE, 'String'))];
    case 2
        opt_start_pt = [str2double(get(handles.editA, 'String')) ...
                        str2double(get(handles.editB, 'String')) ...
                        str2double(get(handles.editC, 'String')) ...
                        str2double(get(handles.editD, 'String'))];
    case 3
        opt_start_pt = [str2double(get(handles.editA, 'String')) ...
                        str2double(get(handles.editB, 'String'))];
    otherwise
end
compartments = handles.compartments;
model        = get(handles.editEquation, 'String');



if~isdeployed
    cd(PathName)
    if ispc
        addpath('C:\zmf\GUI')
        addpath('C:\zmf\code')
    elseif isunix
        addpath('/home/angelo/Documents/Workspace/GFRmeasure');
    end
else
    FileName = [PathName FileName];  
    strr  = ['The file path is : ' FileName];
    set(handles.edit5, 'String', strr);
end

%% Read data
handles.filename = FileName;
guidata            (hObject, handles);
if strcmp(ext,'.xlsx')
    [~, ~, raw]      = xlsread(FileName);
    raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
    R                = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);
    raw(R)           = {NaN}; 
    % Create output variable
    data1     = reshape([raw{:}],size(raw));
else
    %rt is permission r for read t for open in text mode
    csv_file = fopen(FileName,'rt');

    %the formatspec represents what the scan is 'looking'for. 
    formatSpec = '%{HH:mm:ss}D%{HH:mm:ss}D%f%q%[^\n\r]';

    %textscan inputs work in pairs so your scanning the file using the format
    %defined above and with a semicolon delimeter
    raw = textscan(csv_file, formatSpec, 'Delimiter', ';', 'EmptyValue' ,NaN, 'ReturnOnError', false);

    fclose(csv_file);
    data1(:,1) = raw(:,2);
    data1(:,2) = raw(:,3);
end

% Create table
stefexp   = table;
% Allocate imported array to column variable names

if strcmp(ext,'.csv')
    data2 = data1(:,1);
    data3 = data1(:,2);
    stefexp.TimeLabel = data2{:};
    stefexp.Response  = data3{:};
else
    stefexp.TimeLabel = data1(:,1);
    stefexp.Response  = data1(:,2);
end
% Clear temporary variables
clearvars  data1 raw R;

% fid      = fopen(filename);
% %fid     = fopen(fullfile(ctfroot, 'G', 'Cristina', 'ABZWCY', 'GFR', 'B.csv'));
% data     = textscan(fid, '%s %s %f %s', 'Delimiter',';');
% fclose     (fid);
% response = data{3};
% dt       = data{2};
% dt       = strrep(dt, '"', '');
% Change time axis values to minutes format

time      = datetime(stefexp.TimeLabel,'ConvertFrom','datenum', ...
                                       'InputFormat','hh:mm:ss');
date_time = datevec(time);

for i = 1 : length(date_time)
    hour           = date_time(i,4);
    mins           = date_time(i,5);
    sec            = date_time(i,6);
    m1             = hour*60;
    m2             = sec/60;
    date_time(i,7) = m1 + mins + m2;
end
t  = double(date_time(2:end,7));
d1 = double(t);                       % time
d2 = double(stefexp.Response(2:end));  % signal


%% Specify start point graphically
% Choose important data
d2med   = medfilt1(d2,200);
[~,L]   = findpeaks(d2med,'SortStr', 'descend');
% Ask for user input -> specify injection & cutoff points graphically
cla
cla       reset
plot      (d2(1:L(1)),'parent',handles.axes1);
grid      on
title     ('Please input start point using double-click');
xlabel    ('time points')
ylabel    ('Signal')
[py,~]  = getpts(gcf);
startpt = min(floor(py));
plot(d2)
[py,~]  = getpts(gcf);
endpt   = max(floor(py));

%% Pre-processing
offset = max(5,offset);
if startpt-offset > 0
    medval = median(d2(max(startpt-offset,5):startpt)); % medline value
else
    medval = median(d2med(1:startpt));
end
    
I      = d2(startpt:endpt); % TRIMMED I (from injection to cutoff)
t      = d1(startpt:endpt); % TRIMMED t (from injection to cutoff)
t      = t - t(1);   % baseline adjustment for time
Ishift = (I-medval); % baseline adjustment for the signal
Inorm  = (Ishift-min(Ishift))/abs(max(Ishift)-min(Ishift)); % normalization
Imed   = medfilt1(Inorm,1); % median filter application on signal

%% Curve fitting function (3e)
p0        = opt_start_pt;                     %[1.24 0.63 -0.02 -0.1 -0.5]
lb        = [-100, -20, -0.99, -.99, -.5];
ub        = [100, 20, 0.99, .99, .5];
modelstr  = ['@(p,t)' model];
func      = str2func(modelstr);
options   = optimoptions(@lsqcurvefit,'MaxFunctionEvaluations',1500);
[P, res]  = lsqcurvefit(func, p0, t, Imed, lb, ub, options);
fitresult = feval(func, P,t);
str{3}    = sprintf  ('Residual Error (3e) = %1.3f \n', res);

if fitresult(end) > 0.15
    % extrapolate the function here
    if fitresult(end) < 0.2
        x_ext = t(end)+1:0.01:(1+fitresult(end))*t(end);
    else
        x_ext = t(end)+1:0.01:5*t(end);
    end
    t_o       = t;
    t         = [t; x_ext'];
    fitresult = feval(func, P, t);
else
    t_o = t;
end
    

%% Calculating half-life
if compartments == 2 || compartments == 3
    t_12 = log(2)/abs(P(3));
else
    t_12 = log(2)/abs(P(2));
end
str{1}   = sprintf  ('Half-life (3e) ~ %3.1f mins\n', t_12);
if compartments == 3
    str{4} = sprintf(...
        '3e parameters \n --------------- \n p(1) = %1.2f \n p(2) = %1.2f \n p(3) = %1.4f \n p(4) = %2.4f \n p(5) = %2.4f \n',...
    P(1), P(2), P(3), P(4), P(5));
elseif compartments == 2
    str{4} = sprintf('p(1) = %1.2f \n p(2) = %1.4f \n p(3) = %1.4f \n p(4) = %2.4f \n',...
        P(1), P(2), P(3), P(4));
elseif compartments == 1
    str{4} = sprintf('p(1) = %1.2f \n p(2) = %1.2f \n', P(1), P(2));
end
set(handles.edit5, 'String', str);


%% 1eFit from (15%-50%)
curve     = fitresult;
[pk, ind] = max(curve);
lowlimit  = (15/100)*abs(pk);
highlimit = (50/100)*abs(pk);
lowinds   = curve(ind:end)> lowlimit - 0.005 & ...
            curve(ind:end) < lowlimit + 0.005;
lowloc    = find(lowinds == 1, 1,'last');
highinds  = curve(ind:end) > highlimit - 0.005 & ...
            curve(ind:end) < highlimit + 0.005;
highloc   = find(highinds == 1, 1,'last');

if ~isempty(lowloc) && ~isempty(highloc)
    S3     = curve(highloc+ind-1:lowloc+ind-1);
    Smed3  = S3;
    t3     = t(highloc+ind-1:lowloc+ind-1);
    fun    = @(x,t3)x(1)*exp(x(2)*t3);
    x0     = [2,-0.2];
    x      = lsqcurvefit(fun, x0, t3, Smed3);
    t12    = log(2)/abs(x(2));
    str{2} = sprintf('Half-life (1e) ~ %3.1f mins\n', t12);
    str{5} = sprintf('\n 1e parameters \n --------------- \n p(1) = %1.2f \n p(2) = %2.4f \n', x(1), x(2));
else
    t3     = [];
    str{2} = sprintf('Half-life (1e) ~ Very large value (krank)');
end

%% Calculating AUC
auavc  = trapz(t, fitresult);
str{6} = sprintf  ('AUC : %2.2f \n', auavc);
set      (handles.edit5, 'String', str);


%% Plot data
plot(t_o, Imed, 'bo', 'LineWidth', 2)
hold on
plot(t, fitresult, 'g', 'LineWidth', 5)
grid on
xlim([min(t) max(t)])
ylim([-0.1 1.2])
% stem([curve(1);curve(end)], [t(1);t(end)], 'LineStyle', '-.', ...
%     'MarkerFaceColor', 'red', 'MarkerEdgeColor','green')
if ~isempty(t3)
    hold on
    plot(t3, Smed3, 'r-', 'LineWidth', 5)
    stem(min(t3(1)+t_12,t3(end)), ...
        feval(func, P, min(t3(1)+t_12,t3(end))), ...
    '-o', 'MarkerFaceColor', 'yellow', 'MarkerEdgeColor', 'black', ...
    'MarkerSize', 10)
end

handles.filedispname = strrep(handles.filename, '_', '\_');
title (['GFR function fitting: \it' num2str(handles.filedispname)])
ylabel('Intensity Signal')
xlabel('Time (mins)')

if compartments == 1
    model = 'a*e^b^*^t';
elseif compartments == 2
    model = 'a*e^b^*^t + c*e^d^*^t';
elseif compartments == 3
    model = '(a+b)*e^c^*^t - a*e^d^*^t - b*e^e^*^t';
end

text(30, 1.1, ['Compartment-' num2str(compartments) ' \it f \rm: ' ...
    model], 'Color', 'green', 'FontSize', 18)
text(t_12+t(1), -0.05, sprintf('t_1_/_2 = %2.1f min', t_12), ...
    'Color', 'black', 'FontSize', 14)
legend('Rawdata', [num2str(compartments) 'eFit'], '1eFit', 'Half-Life')

handles.string = str;
guidata(hObject, handles);





function edit2_Callback(hObject, ~, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
handles.offset = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
handles.lowperc = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
handles.highperc = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editA_Callback(hObject, eventdata, handles)
% hObject    handle to editA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editA as text
%        str2double(get(hObject,'String')) returns contents of editA as a double


% --- Executes during object creation, after setting all properties.
function editA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editB_Callback(hObject, eventdata, handles)
% hObject    handle to editB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editB as text
%        str2double(get(hObject,'String')) returns contents of editB as a double


% --- Executes during object creation, after setting all properties.
function editB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editC_Callback(hObject, eventdata, handles)
% hObject    handle to editC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editC as text
%        str2double(get(hObject,'String')) returns contents of editC as a double


% --- Executes during object creation, after setting all properties.
function editC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editD_Callback(hObject, eventdata, handles)
% hObject    handle to editD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editD as text
%        str2double(get(hObject,'String')) returns contents of editD as a double


% --- Executes during object creation, after setting all properties.
function editD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editE_Callback(hObject, eventdata, handles)
% hObject    handle to editE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editE as text
%        str2double(get(hObject,'String')) returns contents of editE as a double


% --- Executes during object creation, after setting all properties.
function editE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
handles = guidata(hObject);  % Update!
switch get(handles.popupmenu3,'Value')   
  case 1
      set(handles.editC, 'enable', 'on')
      set(handles.editD, 'enable', 'on')
      set(handles.editE, 'enable', 'on')
      set(handles.textC, 'enable', 'on')
      set(handles.textD, 'enable', 'on')
      set(handles.textE, 'enable', 'on')
      set(handles.editA,'string',1.24);
      set(handles.editB,'string',0.63);
      set(handles.editC,'string',-0.01);
      set(handles.editD,'string',-0.1);
      set(handles.editE,'string',-0.5);
      set(handles.editEquation,'string','(p(1)+p(2))*exp(p(3)*t)-p(1)*exp(p(4)*t)-p(2)*exp(p(5)*t)');
      handles.compartments = 3;
  case 2
      set(handles.editE, 'enable', 'off')
      set(handles.textE, 'enable', 'off')
      set(handles.editA,'string',0.83);
      set(handles.editB,'string',0.54);
      set(handles.editC,'string',1.00);
      set(handles.editD,'string',0.08);
      set(handles.editEquation,'string','p(1)*exp(p(2)*t) + p(3)*exp(p(4)*t)');
      handles.compartments = 2;
  case 3      
      set(handles.editC, 'enable', 'off')
      set(handles.editD, 'enable', 'off')
      set(handles.editE, 'enable', 'off')
      set(handles.textC, 'enable', 'off')
      set(handles.textD, 'enable', 'off')
      set(handles.textE, 'enable', 'off')
      set(handles.editA,'string',0.80);
      set(handles.editB,'string',-1.39);
      set(handles.editEquation,'string','p(1)*exp(p(2)*t)');
      handles.compartments = 1;
  otherwise
end 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEquation_Callback(hObject, eventdata, handles)
% hObject    handle to editEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEquation as text
%        str2double(get(hObject,'String')) returns contents of editEquation as a double


% --- Executes during object creation, after setting all properties.
function editEquation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over editEquation.
function editEquation_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to editEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
