%% clear
clear all; clc; close all;
%% Load data
fprintf('Loading data ...')

% direct path
path = '/Users/adityavinodh/Documents/MATLAB/Shadmehr Lab';
name = '201125_170140_01_001_combine_3.mat';

% UI
% [name, path] = uigetfile;

load([path filesep name ])
fprintf(' --> completed.')

%% build common variables 
ang_max = LICKS_ALL_DATA.tongue_ang_max;
edges = [-100,-60,-20,20,60,100];
onset_time = LICKS_ALL_DATA.time_onset;
time_onset = LICKS_ALL_DATA.time_onset;
bins = discretize(ang_max,edges);
ang_binned = [ang_max;bins;onset_time];
ss_onset = LICKS_ALL_DATA.neuro_SS_onset;
ss_onset_binned = [ss_onset;ang_max;bins];
cs_onset = LICKS_ALL_DATA.neuro_CS_onset;
cs_onset_binned = [cs_onset;ang_max;bins];
% histogram(ang_bin_neg60(1,:))

%% build bin 1 variables

ang_bin_neg60 = ang_binned(:,ang_binned(2,:) == 1);
idx_ang_neg60 = find(ang_binned(2,:)==1);
dm_ang_neg60 = LICKS_ALL_DATA.tongue_dm_onset(:,idx_ang_neg60);
time_onset_ang_neg60 = time_onset(:,idx_ang_neg60)/10;

mean_dm_neg60 = mean(dm_ang_neg60,2);
ss_ang_neg60 = ss_onset_binned(:,idx_ang_neg60);
sum_ss_onset_neg20 = sum(ss_ang_neg60(1:2000,:),2);
sum_ss_onset_neg20_smoothed = ESN_smooth(sum_ss_onset_neg20, 5);
cs_ang_neg60 = cs_onset_binned(:,idx_ang_neg60);
sum_cs_onset_neg60 = sum(cs_ang_neg60(1:2000,:),2);
mean_dm_neg60_scaled = mean_dm_neg60*7.5;
sum_cs_onset_neg60_scaled = (sum_cs_onset_neg60)*100;
sum_cs_onset_neg60_smoothed = ESN_smooth(sum_cs_onset_neg60_scaled, 200);
[row_ss_neg60, col_ss_neg60] = find(ss_onset_binned (2002,:) == 1 & ss_onset_binned (1:2000,:) ==1);
[row_cs_neg60, col_cs_neg60] = find(cs_onset_binned (2002,:) == 1 & cs_onset_binned (1:2000,:) ==1);
raster_times_ss_neg60 = row_ss_neg60 - 1000;
raster_times_cs_neg60 = row_cs_neg60 - 1000;
[As_neg60,~,ssID_neg60] = unique(col_ss_neg60, 'rows','stable');
ss_raster_heights_neg60 = [ssID_neg60];
[Ac_neg60,~,csID_neg60] = unique(col_cs_neg60, 'rows','stable');
cs_raster_heights_neg60 = [csID_neg60]

%time vec
time_x = -999:1:1000;
%% subplot 1
figure
subplot(2,3,1)
yyaxis right
ylim manual
ylim ([0 300])
plot(time_x,mean_dm_neg60_scaled,'LineWidth',1,'Color','k')
lickplot = area(time_x,mean_dm_neg60_scaled, 'FaceColor',[0 0.5 0])
alpha(lickplot,.4)
hold on
yyaxis left
ylim manual
ylim ([0 500])
scatter(raster_times_ss_neg60,ss_raster_heights_neg60,'filled')
scatter(raster_times_cs_neg60,cs_raster_heights_neg60,15,'filled','MarkerFaceColor','#A2142F')
plot(time_x,sum_ss_onset_neg20_smoothed,'LineWidth',2,'Color','blue')
plot(time_x,sum_cs_onset_neg60_smoothed,'LineWidth',3,'Color','red')
xline(0,'Color','#EDB120','LineWidth',2)
xticks([-800 -600 -400 -200 0 200 400 600 800 1000])
hold off
%% build bin 2 variables

ang_bin_neg20 = ang_binned(:,ang_binned(2,:) == 2);
idx_ang_neg20 = find(ang_binned(2,:)==2);
dm_ang_neg20 = LICKS_ALL_DATA.tongue_dm_onset(:,idx_ang_neg20);
time_onset_ang_neg20 = time_onset(:,idx_ang_neg20)/10;

mean_dm_neg20 = mean(dm_ang_neg20,2);
ss_ang_neg20 = ss_onset_binned(:,idx_ang_neg20);
sum_ss_onset_neg20 = sum(ss_ang_neg20(1:2000,:),2);
sum_ss_onset_neg20_smoothed = ESN_smooth(sum_ss_onset_neg20, 5);
cs_ang_neg20 = cs_onset_binned(:,idx_ang_neg20);
sum_cs_onset_neg20 = sum(cs_ang_neg20(1:2000,:),2);
mean_dm_neg20_scaled = mean_dm_neg20*7.5;
sum_cs_onset_neg20_scaled = (sum_cs_onset_neg20)*100;
sum_cs_onset_neg20_smoothed = ESN_smooth(sum_cs_onset_neg20_scaled, 200);
[row_ss_neg20, col_ss_neg20] = find(ss_onset_binned (2002,:) == 2 & ss_onset_binned (1:2000,:) ==1);
[row_cs_neg20, col_cs_neg20] = find(cs_onset_binned (2002,:) == 2 & cs_onset_binned (1:2000,:) ==1);
raster_times_ss_neg20 = row_ss_neg20 - 1000;
raster_times_cs_neg20 = row_cs_neg20 - 1000;
[As_neg20,~,ssID_neg20] = unique(col_ss_neg20, 'rows','stable');
ss_raster_heights_neg20 = [ssID_neg20];
[Ac_neg20,~,csID_neg20] = unique(col_cs_neg20, 'rows','stable');
cs_raster_heights_neg20 = [csID_neg20]
%% subplot 2
subplot(2,3,2)
yyaxis right
ylim manual
ylim ([0 300])
plot(time_x,mean_dm_neg20_scaled,'LineWidth',1,'Color','k')
lickplot = area(time_x,mean_dm_neg20_scaled, 'FaceColor',[0 0.5 0])
alpha(lickplot,.4)
hold on
yyaxis left
ylim manual
ylim ([0 500])
scatter(raster_times_ss_neg20,ss_raster_heights_neg20,'filled')
scatter(raster_times_cs_neg20,cs_raster_heights_neg20,15,'filled','MarkerFaceColor','#A2142F')
plot(time_x,sum_ss_onset_neg20_smoothed,'LineWidth',2,'Color','blue')
plot(time_x,sum_cs_onset_neg20_smoothed,'LineWidth',3,'Color','red')
xline(0,'Color','#EDB120','LineWidth',2)
xticks([-800 -600 -400 -200 0 200 400 600 800 1000])
hold off

%% build bin 3 variables

ang_bin_pos20 = ang_binned(:,ang_binned(2,:) == 3);
idx_ang_pos20 = find(ang_binned(2,:)==3);
dm_ang_pos20 = LICKS_ALL_DATA.tongue_dm_onset(:,idx_ang_pos20);
time_onset_ang_pos20 = time_onset(:,idx_ang_pos20)/10;

mean_dm_pos20 = mean(dm_ang_pos20,2);
ss_ang_pos20 = ss_onset_binned(:,idx_ang_pos20);
sum_ss_onset_pos20 = sum(ss_ang_pos20(1:2000,:),2);
sum_ss_onset_pos20_smoothed = ESN_smooth(sum_ss_onset_pos20, 5);
cs_ang_pos20 = cs_onset_binned(:,idx_ang_pos20);
sum_cs_onset_pos20 = sum(cs_ang_pos20(1:2000,:),2);
mean_dm_pos20_scaled = mean_dm_pos20*7.5;
sum_cs_onset_pos20_scaled = (sum_cs_onset_pos20)*100;
sum_cs_onset_pos20_smoothed = ESN_smooth(sum_cs_onset_pos20_scaled, 200);
[row_ss_pos20, col_ss_pos20] = find(ss_onset_binned (2002,:) == 3 & ss_onset_binned (1:2000,:) ==1);
[row_cs_pos20, col_cs_pos20] = find(cs_onset_binned (2002,:) == 3 & cs_onset_binned (1:2000,:) ==1);
raster_times_ss_pos20 = row_ss_pos20 - 1000;
raster_times_cs_pos20 = row_cs_pos20 - 1000;
[As_pos20,~,ssID_pos20] = unique(col_ss_pos20, 'rows','stable');
ss_raster_heights_pos20 = [ssID_pos20];
[Ac_pos20,~,csID_pos20] = unique(col_cs_pos20, 'rows','stable');
cs_raster_heights_pos20 = [csID_pos20]
%% subplot 3
subplot(2,3,3)
yyaxis right
ylim manual
ylim ([0 300])
plot(time_x,mean_dm_pos20_scaled,'LineWidth',1,'Color','k')
lickplot = area(time_x,mean_dm_pos20_scaled, 'FaceColor',[0 0.5 0])
alpha(lickplot,.4)
hold on
yyaxis left
ylim manual
ylim ([0 500])
scatter(raster_times_ss_pos20,ss_raster_heights_pos20,'filled')
scatter(raster_times_cs_pos20,cs_raster_heights_pos20,15,'filled','MarkerFaceColor','#A2142F')
plot(time_x,sum_ss_onset_pos20_smoothed,'LineWidth',2,'Color','blue')
plot(time_x,sum_cs_onset_pos20_smoothed,'LineWidth',3,'Color','red')
xline(0,'Color','#EDB120','LineWidth',2)
xticks([-800 -600 -400 -200 0 200 400 600 800 1000])
hold off
%% %% build bin 4 variables

ang_bin_pos60 = ang_binned(:,ang_binned(2,:) == 3);
idx_ang_pos60 = find(ang_binned(2,:)==3);
dm_ang_pos60 = LICKS_ALL_DATA.tongue_dm_onset(:,idx_ang_pos60);
time_onset_ang_pos60 = time_onset(:,idx_ang_pos60)/10;

mean_dm_pos60 = mean(dm_ang_pos60,2);
ss_ang_pos60 = ss_onset_binned(:,idx_ang_pos60);
sum_ss_onset_pos60 = sum(ss_ang_pos60(1:2000,:),2);
sum_ss_onset_pos60_smoothed = ESN_smooth(sum_ss_onset_pos60, 5);
cs_ang_pos60 = cs_onset_binned(:,idx_ang_pos60);
sum_cs_onset_pos60 = sum(cs_ang_pos60(1:2000,:),2);
mean_dm_pos60_scaled = mean_dm_pos60*7.5;
sum_cs_onset_pos60_scaled = (sum_cs_onset_pos60)*100;
sum_cs_onset_pos60_smoothed = ESN_smooth(sum_cs_onset_pos60_scaled, 200);
[row_ss_pos60, col_ss_pos60] = find(ss_onset_binned (2002,:) == 4 & ss_onset_binned (1:2000,:) ==1);
[row_cs_pos60, col_cs_pos60] = find(cs_onset_binned (2002,:) == 4 & cs_onset_binned (1:2000,:) ==1);
raster_times_ss_pos60 = row_ss_pos60 - 1000;
raster_times_cs_pos60 = row_cs_pos60 - 1000;
[As_pos60,~,ssID_pos60] = unique(col_ss_pos60, 'rows','stable');
ss_raster_heights_pos60 = [ssID_pos60];
[Ac_pos60,~,csID_pos60] = unique(col_cs_pos60, 'rows','stable');
cs_raster_heights_pos60 = [csID_pos60]
%% subplot 4

subplot(2,3,4)
yyaxis right
ylim manual
ylim ([0 300])
plot(time_x,mean_dm_pos60_scaled,'LineWidth',1,'Color','k')
lickplot = area(time_x,mean_dm_pos60_scaled, 'FaceColor',[0 0.5 0])
alpha(lickplot,.4)
hold on
yyaxis left
ylim manual
ylim ([0 500])
scatter(raster_times_ss_pos60,ss_raster_heights_pos60,'filled')
scatter(raster_times_cs_pos60,cs_raster_heights_pos60,15,'filled','MarkerFaceColor','#A2142F')
plot(time_x,sum_ss_onset_pos60_smoothed,'LineWidth',2,'Color','blue')
plot(time_x,sum_cs_onset_pos60_smoothed,'LineWidth',3,'Color','red')
xline(0,'Color','#EDB120','LineWidth',2)
xticks([-800 -600 -400 -200 0 200 400 600 800 1000])
hold off
%% %% %% build bin 5 variables

ang_bin_pos100 = ang_binned(:,ang_binned(2,:) == 3);
idx_ang_pos100 = find(ang_binned(2,:)==3);
dm_ang_pos100 = LICKS_ALL_DATA.tongue_dm_onset(:,idx_ang_pos100);
time_onset_ang_pos100 = time_onset(:,idx_ang_pos100)/10;

mean_dm_pos100 = mean(dm_ang_pos100,2);
ss_ang_pos100 = ss_onset_binned(:,idx_ang_pos100);
sum_ss_onset_pos100 = sum(ss_ang_pos100(1:2000,:),2);
sum_ss_onset_pos100_smoothed = ESN_smooth(sum_ss_onset_pos100, 5);
cs_ang_pos100 = cs_onset_binned(:,idx_ang_pos100);
sum_cs_onset_pos100 = sum(cs_ang_pos100(1:2000,:),2);
mean_dm_pos100_scaled = mean_dm_pos100*7.5;
sum_cs_onset_pos100_scaled = (sum_cs_onset_pos100)*100;
sum_cs_onset_pos100_smoothed = ESN_smooth(sum_cs_onset_pos100_scaled, 200);
[row_ss_pos100, col_ss_pos100] = find(ss_onset_binned (2002,:) == 5 & ss_onset_binned (1:2000,:) ==1);
[row_cs_pos100, col_cs_pos100] = find(cs_onset_binned (2002,:) == 5 & cs_onset_binned (1:2000,:) ==1);
raster_times_ss_pos100 = row_ss_pos100 - 1000;
raster_times_cs_pos100 = row_cs_pos100 - 1000;
[As_pos100,~,ssID_pos100] = unique(col_ss_pos100, 'rows','stable');
ss_raster_heights_pos100 = [ssID_pos100];
[Ac_pos100,~,csID_pos100] = unique(col_cs_pos100, 'rows','stable');
cs_raster_heights_pos100 = [csID_pos100]
%% subplot 6

subplot(2,3,6)
yyaxis right
ylim manual
ylim ([0 300])
plot(time_x,mean_dm_pos100_scaled,'LineWidth',1,'Color','k')
lickplot = area(time_x,mean_dm_pos100_scaled, 'FaceColor',[0 0.5 0])
alpha(lickplot,.4)
hold on
yyaxis left
ylim manual
ylim ([0 500])
scatter(raster_times_ss_pos100,ss_raster_heights_pos100,'filled')
scatter(raster_times_cs_pos100,cs_raster_heights_pos100,15,'filled','MarkerFaceColor','#A2142F')
plot(time_x,sum_ss_onset_pos100_smoothed,'LineWidth',2,'Color','blue')
plot(time_x,sum_cs_onset_pos100_smoothed,'LineWidth',3,'Color','red')
xline(0,'Color','#EDB120','LineWidth',2)
xticks([-800 -600 -400 -200 0 200 400 600 800 1000])
hold off

