%%
cfg                 = [];
cfg.output          = 'pow';
cfg.method          = 'mtmfft';
cfg.taper           = 'hanning';
cfg.foi             = 2:0.25:45;  
cfg.keeptrials      = 'yes';
cfg.pad             = 'maxperlen';
pow                 = ft_freqanalysis(cfg,data_cl);

idx_RS1             = pow.trialinfo(:,1) == 1;
idx_RS2             = pow.trialinfo(:,1) == 2;

meanPowerSpectrum   = squeeze(mean(mean(pow.powspctrm, 1), 2));             % power spectrum for both resting states
                                                                            % averaged across channels and trials
figure(78)
plot(pow.freq, meanPowerSpectrum, 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Mean power');
title('Mean Power Spectrum');

power_RS1 = squeeze(mean(mean(pow.powspctrm(idx_RS1,:,:), 1), 2));          % power spectrum for first resting state
power_RS2 = squeeze(mean(mean(pow.powspctrm(idx_RS2,:,:), 1), 2));          % power spectrum for second resting state

figure(79)
plot(pow.freq, power_RS1, 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Mean power');
title('Resting State 1 Power Spectrum');

figure(80)
plot(pow.freq, power_RS2, 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Mean power');
title('Resting State 2 Power Spectrum');
%%
% foi = frequencies of interest
foi                 = 8:0.2:13;                                             % alpha band 8-13 Hz, step size 0.2

cfg                 = [];
cfg.output          = 'pow';
cfg.method          = 'mtmfft';
cfg.taper           = 'hanning';
cfg.foi             = foi;  
cfg.keeptrials      = 'yes';
cfg.pad             = 'maxperlen';
TFRhann             = ft_freqanalysis(cfg,data_cl);                         % TFR = time frequency representation

alphaPower          = mean(TFRhann.powspctrm, 3);
idx_RS1             = TFRhann.trialinfo(:,1) == 1;
idx_RS2             = TFRhann.trialinfo(:,1) == 2;

alphaPower_RS1      = alphaPower(idx_RS1, :);
alphaPower_RS2      = alphaPower(idx_RS2, :);


alphaPower_RS1_AllChans = mean(alphaPower_RS1,2);
alphaPower_RS2_AllChans = mean(alphaPower_RS2,2);

meanAlpha_RS1           = mean(alphaPower_RS1_AllChans);
meanAlpha_RS2           = mean(alphaPower_RS2_AllChans);

alphaResults               = struct();
alphaResults.power_RS1     = alphaPower_RS1;                                % power by trial and channel
alphaResults.power_RS2     = alphaPower_RS2;
alphaResults.meanPower_RS1 = meanAlpha_RS1;                                 % mean across trials and channels
alphaResults.meanPower_RS2 = meanAlpha_RS2;

alphaFile = fullfile(fpath.preproc, ...
    [base '_desc-alphaPower_eeg.mat']);
save(alphaFile,"alphaResults");
