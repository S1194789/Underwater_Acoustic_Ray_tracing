%% Data Load 
clear; clc; close all;
load('\Users\HYEJOO KWON\Documents\Acoustic Aqua\Received.mat');

%% Constants
totalDuration = 6.4;
numReflections = 10;
timeStep = 2e-04;
soundSpeed = 1500;
initialPosition = 25;

[numReceivers, signalLength] = size(RecSig);

%% Signal Plotting 
timeAxis = linspace(0, totalDuration, signalLength);

% Extracting Specific Received Signals
signal_1 = RecSig(1,:);
signal_2 = RecSig(2,:);
signal_3 = RecSig(3,:);
signal_4 = RecSig(4,:);
signal_5 = RecSig(5,:);
signal_6 = RecSig(6,:);
signal_7 = RecSig(7,:);
signal_7 = RecSig(8,:);
signal_9 = RecSig(9,:);

%% Plot all received signals
figure;
plot(timeAxis, RecSig);
title('Plot of All Signals');
xlabel('Time (s)'); 
ylabel('Amplitude (m)');
xlim([0.40 6])
ylim([-1.7 1.2])

%% Plot signals around first peak
figure;
plot(timeAxis, signal_1, 'b'); hold on;
plot(timeAxis, signal_2, 'c'); % Signal 2 in cyan
plot(timeAxis, signal_3, 'm'); % Signal 3 in magenta
plot(timeAxis, signal_4, 'r'); % Signal 4 in red
plot(timeAxis, signal_5, 'k'); % Signal 5 in black
plot(timeAxis, signal_6, 'g'); % Signal 6 in green
plot(timeAxis, signal_7, 'y'); % Signal 7 in yellow
plot(timeAxis, signal_7, 'b'); % Signal 7 in yellow
plot(timeAxis, signal_7, 'c'); % Signal 7 in yellow
title('Comparison of Signals 1 to 9');
xlabel('Time (s)'); 
ylabel('Amplitude (m)');
legend('Signal 1', 'Signal 2', 'Signal 3', 'Signal 4', 'Signal 5', ...
       'Signal 6', 'Signal 7', 'Signal 8', 'Signal 9');
xlim([2.2 2.3])
ylim([-0.3 1.2])
hold off;

%% Plot Signal 5
figure;
plot(timeAxis, signal_5, 'm');
title('Plot of Signal 5');
xlabel('Time (s)'); 
ylabel('Amplitude (m)');
xlim([2.048 2.584])
ylim([-0.90 1.01])

%% Calculate Time of Arrival of First Peak 
arrivalTimes = zeros(1, numReceivers);
for receiverIdx = 1:numReceivers
    firstPeakValue = max(RecSig(receiverIdx, 11000:11500));
    firstPeakIndex = find(RecSig(receiverIdx, :) == firstPeakValue, 1); % Take first occurrence
    arrivalTimes(receiverIdx) = firstPeakIndex * timeStep;
    fprintf('Time taken to reach first peak: %f seconds for Receiver %d\n', arrivalTimes(receiverIdx), receiverIdx);
end
%% Backpropagation of Time-Reversed Received Signal
% Estimated Depth
estimatedDepth = 351.4;

% Define Exploration Area (x, z axis)
xPositions = linspace(940, 1020, 30);
zPositions = linspace(120, 130, 30 );

plotMatrix = zeros(length(zPositions), length(xPositions));

% Iterating through exploration area
for xIdx = 1:length(xPositions)
    for zIdx = 1:length(zPositions)
        reconstructedSignal = zeros(size(RecSig));
        for recIdx = 1:numReceivers
            reversedSignal = flip(RecSig(recIdx, :));
            processedSignal = Green(xPositions(xIdx), zPositions(zIdx), 0, initialPosition * recIdx, ...
                                    estimatedDepth, soundSpeed, reversedSignal', timeStep, numReflections);
            reconstructedSignal(recIdx, :) = processedSignal;
        end
        
        totalEnergy = sum(sum(reconstructedSignal .^ 2));
        plotMatrix(zIdx, xIdx) = 10 * log10(totalEnergy);
    end
end

%% Plotting Source Location
figure;
imagesc(xPositions, zPositions, plotMatrix);
colorbar;
title('Plot of the Source');
xlabel('Position (m)') 
ylabel('Depth (m)')
set(gca, 'YDir', 'normal') % Correcting axis direction for depth

%% Green's Function 
function outputSignal = Green(receiverX, receiverZ, sourceX, sourceZ, depth, speed, inputSignal, timeStep, reflectionCount)
    evenPath = @(x, z, j) sqrt((x - sourceX).^2 + (z - sourceZ + j * depth).^2);
    oddPath = @(x, z, j) sqrt((x - sourceX).^2 + (z + sourceZ - (j + 1) * depth).^2);

    samplingFreq = 1 / timeStep;
    outputSignal = zeros(size(inputSignal));

    for j = -reflectionCount:reflectionCount
        if mod(j, 2) == 1
            reflectionSign = -1;
            pathLength = oddPath(receiverX, receiverZ, j);
        else
            reflectionSign = 1;
            pathLength = evenPath(receiverX, receiverZ, j);
        end
        
        delayedSignal = delayseq(inputSignal, pathLength / speed, samplingFreq);
        computedSignal = reflectionSign / (4 * pi * pathLength) * delayedSignal;
        
        outputSignal = outputSignal - computedSignal;
    end
end
