%%%% BME872 - Project %%%%
% Sadaf Safa & Dinh Vu Le %
clear all
addpath("D:\BME872\Lab 1\data\Lab1 - BrainMRI2\Lab1 - BrainMRI2\");
pathCT1 = 'D:\BME872\Lab 1\data\Lab1 - LungCT\Lab1 - LungCT\noise_0.5x_post.mhd';
pathCT2=  'D:\BME872\Lab 1\data\Lab1 - LungCT\Lab1 - LungCT\noise_10x_post.mhd';
pathCT3=  'D:\BME872\Lab 1\data\Lab1 - LungCT\Lab1 - LungCT\training_post.mhd';
[filepathCT1,nameCT1,extCT1] = fileparts(pathCT1);
[filepathCT2, nameCT2, extCT2] = fileparts(pathCT2);
[filepathCT3, nameCT3, extCT3] = fileparts(pathCT3);

%% Load the Images from Brian MRI file and Lung CT file 
% Loading MRI images
ind = 95;
imgBrain1=load("brainMRI_1.mat");
imgBrain1=imgBrain1.vol(:,:,ind);
imgBrain2=load("brainMRI_2.mat");
imgBrain2=imgBrain2.vol(:,:,ind);
imgBrain3=load("brainMRI_3.mat");
imgBrain3=imgBrain3.vol(:,:,ind);
imgBrain4=load("brainMRI_4.mat");
imgBrain4=imgBrain4.vol(:,:,ind);
imgBrain5=load("brainMRI_5.mat");
imgBrain5=imgBrain5.vol(:,:,ind);
imgBrain6=load("brainMRI_6.mat");
imgBrain6=imgBrain6.vol(:,:,ind);

% Loading CT images 
[volCT5, infoCT5] = imageRead(filepathCT1, extCT1, nameCT1);
volCT5=volCT5.data;
[volCT10, infoCT10] = imageRead(filepathCT2, extCT2, nameCT2);
volCT10=volCT10.data;
[volCT, infoCT] = imageRead(filepathCT3, extCT3, nameCT3);
volCT=volCT.data;

ind2 = 143;
volCT5=volCT5(:,:,ind2);
volCT10=volCT10(:,:,ind2);
volCT=volCT(:,:,ind2);

%% Brain MRI images 
[psnrBrain1,varBrain1,histBrain1,wewBrain1]=quality_assessment(imgBrain1,"no","median");
[psnrBrain2,varBrain2,histBrain2,wewBrain2]=quality_assessment(imgBrain2,"no","median");
[psnrBrain3,varBrain3,histBrain3,wewBrain3]=quality_assessment(imgBrain3,"no","median");
[psnrBrain4,varBrain4,histBrain4,wewBrain4]=quality_assessment(imgBrain4,"no","median");
[psnrBrain5,varBrain5,histBrain5,wewBrain5]=quality_assessment(imgBrain5,"no","median");
[psnrBrain6,varBrain6,histBrain6,wewBrain6]=quality_assessment(imgBrain6,"no","median");

%% Lung CT images
[psnrCt1,varCt1,histCt1,wewCt1]=quality_assessment(volCT,"no","median");
[psnrCt5,varCt5,histCt5,wewCt5]=quality_assessment(volCT5,"no","median");
[psnrCt10,varCt10,histCt10,wewCt10]=quality_assessment(volCT10,"no","median");

%% tabulate CT results 
psnrCt=[psnrCt5;psnrCt1;psnrCt10];
varCt=[varCt5;varCt1;varCt10];
histCt=[histCt5;histCt1;histCt10];
wewCt=[wewCt5;wewCt1;wewCt10];
nameCT=["0.5x noise CT Image";"1.0x noise (training) CT Image";"10x noise CT Image"];

varCT=[nameCT,psnrCt,varCt,histCt,wewCt];
tableCT=array2table(varCT,'VariableNames',{'Name','PSNR (dB)', 'Variance','Hist. Spread','WEW score'})

%% tabulate MRI result 
psnrBrain=[psnrBrain1;psnrBrain2;psnrBrain3;psnrBrain4;psnrBrain5;psnrBrain6];
varBrain=[varBrain1;varBrain2;varBrain3;varBrain4;varBrain5;varBrain6];
histBrain=[histBrain1;histBrain2;histBrain3;histBrain4;histBrain5;histBrain6];
wewBrain=[wewBrain1;wewBrain2;wewBrain3;wewBrain4;wewBrain5;wewBrain6];
nameMRI=["Brain MRI 1";"Brain MRI 2";"Brain MRI 3";"Brain MRI 4";"Brain MRI 5";"Brain MRI 6"];

varMRI=[nameMRI,psnrBrain, varBrain ,histBrain,wewBrain];
tableMRI=array2table(varMRI,'VariableNames',{'Name','PSNR (dB)', 'Variance','Hist. Spread','WEW score'})

% Plot of PSNR vs. Var
figure; scatter(psnrBrain,varBrain,"filled"); ylabel("Variance"); xlabel("PSNR"); title("Brain MRI"); grid minor;
figure; scatter(psnrCt,varCt,"filled"); ylabel("Variance"); xlabel("PSNR"); title("Lung CT"); grid minor;

% Plot WEW
nameWEWbrain = categorical(nameMRI); nameWEWCT = categorical(nameCT);
figure; 
scatter(nameWEWbrain, wewBrain, 'filled'); xlabel("Image"); ylabel("WEW score"); title("Brain MRI's WEW");grid minor;
figure; 
scatter(nameWEWCT, wewCt, 'filled'); xlabel("Image"); ylabel("WEW score"); title("Lung CT's WEW");grid minor;

%% Plotting the MRI images 
figure;
subplot(221),imshow(imgBrain1,[]),title("Reference Brain MRI Image")
subplot(222),imshow(imgBrain6,[]), title("Nosiy Brain MRI Image")
subplot(223),histogram(imgBrain1,"Normalization","pdf"), title("Normalized Intensity Histogram")
subplot(224),histogram(imgBrain6,"Normalization","pdf"), title("Normalized Intensity Histogram")

%% Plotting Lung CT images
figure;
subplot(221),imshow(volCT5,[]),title("Reference Lung CT Image")
subplot(222),imshow(volCT10,[]), title("Nosiy Lung CT Image")
subplot(223),histogram(volCT5,"Normalization","pdf"), title("Normalized Intensity Histogram")
subplot(224),histogram(volCT10,"Normalization","pdf"), title("Normalized Intensity Histogram")

%% Save the tables to an xlsx file
filename="872project.xlsx";
writetable(tableCT,filename,'Sheet',1);
writetable(tableMRI,filename,'Sheet',2);

