%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Import raw data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find correct data file
[FILENAME,PATHNAME,FILTERINDEX] = uigetfile('*.hdr','Choose AQD hdr file');
cd(PATHNAME);
clear FILTERINDEX PATHNAME

% Import velocity and sensor data
dat = importdata(strcat(FILENAME(1:end-4),'.dat'));
datsize = size(dat);
if datsize(2)==23
    Datetime = datenum(dat(:,3),dat(:,1),dat(:,2),dat(:,4),dat(:,5),dat(:,6));
    Error = dat(:,7);
    Status = dat(:,8);
    Vel1 = dat(:,9);
    Vel2 = dat(:,10);
    Vel3 = dat(:,11);
    Amp1 = dat(:,12);
    Amp2 = dat(:,13);
    Amp3 = dat(:,14);
    Battery = dat(:,15);
    Soundspeed = dat(:,16);
    Heading = dat(:,17);
    Pitch = dat(:,18);
    Roll = dat(:,19);
    Pressure = dat(:,20);
    Temperature = dat(:,21);
    AnalogIn1 = dat(:,22);
    AnalogIn2 = dat(:,23);
elseif datsize(2)==25
    Datetime = datenum(dat(:,3),dat(:,1),dat(:,2),dat(:,4),dat(:,5),dat(:,6));
    Error = dat(:,7);
    Status = dat(:,8);
    Vel1 = dat(:,9);
    Vel2 = dat(:,10);
    Vel3 = dat(:,11);
    Amp1 = dat(:,12);
    Amp2 = dat(:,13);
    Amp3 = dat(:,14);
    Battery = dat(:,15);
    Soundspeed = dat(:,16);
    Heading = dat(:,17);
    Pitch = dat(:,18);
    Roll = dat(:,19);
    Pressure = dat(:,20);
    Temperature = dat(:,21);
    AnalogIn1 = dat(:,22);
    AnalogIn2 = dat(:,23);
    Speed = dat(:,24);
    Direction = dat(:,25);
elseif datsize(2)==32
    Datetime = datenum(dat(:,3),dat(:,1),dat(:,2),dat(:,4),dat(:,5),dat(:,6));
    Burst = dat(:,7);
    Ensemble = dat(:,8);
    Error = dat(:,9);
    Status = dat(:,10);
    Vel1 = dat(:,11);
    Vel2 = dat(:,12);
    Vel3 = dat(:,13);
    Amp1 = dat(:,14);
    Amp2 = dat(:,15);
    Amp3 = dat(:,16);
    Battery = dat(:,17);
    Soundspeed = dat(:,18);
    Soundspeed_used = dat(:,19);
    Heading = dat(:,20);
    Pitch = dat(:,21);
    Roll = dat(:,22);
    Pressure_dbar = dat(:,23);
    Pressure_m = dat(:,24);
    Temperature = dat(:,25);
    AnalogIn1 = dat(:,26);
    AnalogIn2 = dat(:,27);
    Speed = dat(:,28);
    Direction = dat(:,29);
    MagX = dat(:,30);
    MagY = dat(:,31);
    MagZ = dat(:,32);
end

% If diagnostic data exists, import
if exist(strcat(FILENAME(1:end-4),'.dia'))==2;
    dia = importdata(strcat(FILENAME(1:end-4),'.dia'));
    diasize = size(dia);
    if diasize(2)==25
        dDatetime = datenum(dia(:,3),dia(:,1),dia(:,2),dia(:,4),dia(:,5),dia(:,6));
        dError = dia(:,7);
        dStatus = dia(:,8);
        dVel1 = dia(:,9);
        dVel2 = dia(:,10);
        dVel3 = dia(:,11);
        dAmp1 = dia(:,12);
        dAmp2 = dia(:,13);
        dAmp3 = dia(:,14);
        dBattery = dia(:,15);
        dSoundspeed = dia(:,16);
        dHeading = dia(:,17);
        dPitch = dia(:,18);
        dRoll = dia(:,19);
        dPressure = dia(:,20);
        dTemperature = dia(:,21);
        dAnalogIn1 = dia(:,22);
        dAnalogIn2 = dia(:,23);
        dSpeed = dia(:,24);
        dDirection = dia(:,25);
    elseif diasize(2)==27
        dDatetime = datenum(dia(:,3),dia(:,1),dia(:,2),dia(:,4),dia(:,5),dia(:,6));
        dError = dia(:,7);
        dStatus = dia(:,8);
        dVel1 = dia(:,9);
        dVel2 = dia(:,10);
        dVel3 = dia(:,11);
        dAmp1 = dia(:,12);
        dAmp2 = dia(:,13);
        dAmp3 = dia(:,14);
        dBattery = dia(:,15);
        dSoundspeed = dia(:,16);
        dSoundspeedUsed = dia(:,17);
        dHeading = dia(:,18);
        dPitch = dia(:,19);
        dRoll = dia(:,20);
        dPressuredbar = dia(:,21);
        dPressurem = dia(:,22);
        dTemperature = dia(:,23);
        dAnalogIn1 = dia(:,24);
        dAnalogIn2 = dia(:,25);
        dSpeed = dia(:,26);
        dDirection = dia(:,27);
    end
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Plot raw data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot velocities
figure(1); clf
plot(Datetime,Vel1,'r')
hold on
plot(Datetime,Vel2,'b')
hold on
plot(Datetime,Vel3,'g')
legend('Velocity 1','Velocity 2','Velocity 3',...
    'Location','best')
datetick
xlim([min(Datetime) max(Datetime)])
xlabel('Datetime')
ylabel('Velocity (m/s)')
title(strcat(FILENAME(1:end-4),' velocities'))

% Plot amplitudes
figure(2); clf
plot(Datetime,Amp1,'r')
hold on
plot(Datetime,Amp2,'b')
hold on
plot(Datetime,Amp3,'g')
legend('Amplitude 1','Amplitude 2','Amplitude 3',...
    'Location','best')
datetick
xlim([min(Datetime) max(Datetime)])
xlabel('Datetime')
ylabel('Amplitude (counts)')
title(strcat(FILENAME(1:end-4),' amplitudes'))

% Plot heading, pitch and roll
figure(3); clf
h1 = plot(Datetime,Roll,'r');
hold on
[ax2,h2,h3] = plotyy(Datetime,Pitch,Datetime,Heading);
set(ax2(2),'xlim',[min(Datetime) max(Datetime)],...
    'xticklab',[],'xtick',[],...
    'ylim',[0 360],'ytick',[0:60:360])
legend([h1;h2;h3],'Roll','Pitch','Heading',...
    'Location','best')
datetick
xlim([min(Datetime) max(Datetime)])
xlabel('Datetime')
ylabel('Tilt (°)')
set(get(ax2(2),'Ylabel'),'String','Heading (°)')
title(strcat(FILENAME(1:end-4),' position'))

% Plot temperature and pressure
figure(4); clf
[ax,h1,h2] = plotyy(Datetime,Temperature,Datetime,Pressure);
set(ax(2),'xlim',[min(Datetime) max(Datetime)],...
    'xticklab',[],'xtick',[])
legend([h1;h2],'Temperature','Pressure',...
    'Location','best')
datetick
xlim([min(Datetime) max(Datetime)])
xlabel('Datetime')
ylabel('Temperature (°C)')
set(get(ax(2),'Ylabel'),'String','Pressure (dbar)')
title(strcat(FILENAME(1:end-4),' environment'));





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Plot full diagnostic data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist('dia')
    % Plot diagnostic velocities
    figure(5); clf
    plot(dDatetime,dVel1,'r.')
    hold on
    plot(dDatetime,dVel2,'b.')
    hold on
    plot(dDatetime,dVel3,'g.')
    legend('Diagnostic velocity 1','Diagnostic velocity 2','Diagnostic velocity 3',...
        'Location','best')
    datetick
    xlim([min(dDatetime) max(dDatetime)])
    xlabel('Datetime')
    ylabel('Velocity (m/s)')
    title(strcat(FILENAME(1:end-4),' diagnostic velocities'))

    % Plot diagnostic amplitudes
    figure(6); clf
    plot(dDatetime,dAmp1,'r.')
    hold on
    plot(dDatetime,dAmp2,'b.')
    hold on
    plot(dDatetime,dAmp3,'g.')
    legend('Diagnostic amplitude 1','Diagnostic amplitude 2','Diagnostic amplitude 3',...
        'Location','best')
    datetick
    xlim([min(dDatetime) max(dDatetime)])
    xlabel('Datetime')
    ylabel('Amplitude (counts)')
    title(strcat(FILENAME(1:end-4),' diagnostic amplitudes'))

    % Plot diagnostic heading, pitch and roll
    figure(7); clf
    h1 = plot(dDatetime,dRoll,'r.');
    hold on
    [ax2,h2,h3] = plotyy(dDatetime,dPitch,dDatetime,dHeading);
    set(ax2(2),'xlim',[min(dDatetime) max(dDatetime)],...
        'xticklab',[],'xtick',[],...
        'ylim',[0 360],'ytick',[0:60:360])
    set(h2,'Marker','.','LineStyle','none')
    set(h3,'Marker','.','LineStyle','none')
    legend([h1;h2;h3],'Diagnostic roll','Diagnostic pitch','Diagnotic heading',...
        'Location','best')
    datetick
    xlim([min(Datetime) max(Datetime)])
    xlabel('Datetime')
    ylabel('Tilt (°)')
    set(get(ax2(2),'Ylabel'),'String','Heading (°)')
    title(strcat(FILENAME(1:end-4),' diagnostic position'))

    % Plot diagnostic temperature and pressure
    figure(8); clf
    [ax,h1,h2] = plotyy(dDatetime,dTemperature,dDatetime,dPressure);
    set(ax(2),'xlim',[min(dDatetime) max(dDatetime)],...
        'xticklab',[],'xtick',[])
    set(h1,'Marker','.','LineStyle','none')
    set(h2,'Marker','.','LineStyle','none')
    legend([h1;h2],'Diagnostic temperature','Diagnostic pressure',...
        'Location','best')
    datetick
    xlim([min(dDatetime) max(dDatetime)])
    xlabel('Datetime')
    ylabel('Temperature (°C)')
    set(get(ax(2),'Ylabel'),'String','Pressure (dbar)')
    title(strcat(FILENAME(1:end-4),' diagnostic environment'));
end




