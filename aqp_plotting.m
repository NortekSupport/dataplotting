%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Import raw data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find correct data file
[FILENAME,PATHNAME,FILTERINDEX] = uigetfile('*.hdr','Choose AQP hdr file');
cd(PATHNAME);
clear FILTERINDEX PATHNAME

% Import velocity and sensor data
Vel1 = importdata(strcat(FILENAME(1:end-4),'.v1')); Vel1 = Vel1(:,3:end);
Vel2 = importdata(strcat(FILENAME(1:end-4),'.v2')); Vel2 = Vel2(:,3:end);
Vel3 = importdata(strcat(FILENAME(1:end-4),'.v3')); Vel3 = Vel3(:,3:end);
Amp1 = importdata(strcat(FILENAME(1:end-4),'.a1')); Amp1 = Amp1(:,3:end);
Amp2 = importdata(strcat(FILENAME(1:end-4),'.a2')); Amp2 = Amp2(:,3:end);
Amp3 = importdata(strcat(FILENAME(1:end-4),'.a3')); Amp3 = Amp3(:,3:end);
velsize = size(Vel1);

sen = importdata(strcat(FILENAME(1:end-4),'.sen'));
sensize = size(sen);
Datetime = datenum(sen(:,3),sen(:,1),sen(:,2),...
    sen(:,4),sen(:,5),sen(:,6));
if sensize(2)==17
    Error = sen(:,7);
    Status = sen(:,8);
    Battery = sen(:,9);
    Soundspeed = sen(:,10);
    Heading = sen(:,11);
    Pitch = sen(:,12);
    Roll = sen(:,13);
    Pressure = sen(:,14);
    Temperature = sen(:,15);
    Analog1 = sen(:,16);
    Analog2 = sen(:,17);
end
clear sen sensize






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Plot raw data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Velocity

figure(1); clf
subplot(3,1,1)
pcolor(Datetime,1:velsize(2),Vel1')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' velocity 1 (m/s)'))
xlabel('Datetime')
ylabel('Cell number')
subplot(3,1,2)
pcolor(Datetime,1:velsize(2),Vel2')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' velocity 2 (m/s)'))
xlabel('Datetime')
ylabel('Cell number')
subplot(3,1,3)
pcolor(Datetime,1:velsize(2),Vel3')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' velocity 3 (m/s)'))
xlabel('Datetime')
ylabel('Cell number')

%% Amplitude

figure(2); clf
subplot(3,1,1)
pcolor(Datetime,1:velsize(2),Amp1')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' amplitude 1 (counts)'))
xlabel('Datetime')
ylabel('Cell number')
subplot(3,1,2)
pcolor(Datetime,1:velsize(2),Amp2')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' amplitude 2 (counts)'))
xlabel('Datetime')
ylabel('Cell number')
subplot(3,1,3)
pcolor(Datetime,1:velsize(2),Amp3')
shading flat
datetick
xlim([min(Datetime) max(Datetime)])
colorbar
title(strcat(FILENAME(1:end-4),' amplitude 3 (counts)'))
xlabel('Datetime')
ylabel('Cell number')

%% Sensors

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



