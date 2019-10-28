function hFigWav = plotFigWav(hFigWav, hClust, maxAmp)
    %PLOTFIGWAV Plot the main view (FigWav)
    if ~hFigWav.hasAxes('default') % construct from scratch
        hFigWav.addAxes('default');
        hFigWav.axApply('default', @set, 'Position', [.05 .05 .9 .9], 'XLimMode', 'manual', 'YLimMode', 'manual');
        hFigWav.axApply('default', @xlabel, 'Unit #');
        hFigWav.axApply('default', @ylabel, 'Site #');
        hFigWav.axApply('default', @grid, 'on');

        % hFigWav.figData.vcTitle = 'Scale: %0.1f uV; [H]elp; [Left/Right]:Select cluster; (Sft)[Up/Down]:scale; [M]erge; [S]plit auto; [D]elete; [A]:Resample spikes; [P]STH; [Z]oom; in[F]o; [Space]:Find similar [0]:Annotate Delete [1]:Annotate Signle [2]:Annotate Multi'; % TW
        % hFigWav.axApply('default', @title, sprintf('Scale: %0.1f uV; [H]elp; [Left/Right]:Select cluster; (Sft)[Up/Down]:scale; [M]erge; [S]plit auto; [D]elete; [A]:Resample spikes; [P]STH; [Z]oom; in[F]o; [Space]:Find similar [0]:Annotate Delete [1]:Annotate Signle [2]:Annotate Multi', maxAmp));
        
        hFigWav.axApply('default', @axis, [0, hClust.nClusters + 1, 0, hClust.hCfg.nSites + 1]);
        hFigWav = plotSpikeWaveforms(hFigWav, hClust, maxAmp);
        hFigWav = plotMeanWaveforms(hFigWav, hClust, maxAmp);
        hFigWav.setHideOnDrag('hSpkAll');
    else
        hFigWav = plotSpikeWaveforms(hFigWav, hClust, maxAmp);
        % clear mean waveforms
        iGroup = 1;
        while hFigWav.hasPlot(sprintf('Group%d', iGroup))
            hFigWav.rmPlot(sprintf('Group%d', iGroup));
            iGroup = iGroup + 1;
        end
        % replot mean waveforms
        hFigWav = plotMeanWaveforms(hFigWav, hClust, maxAmp);
    end

    info_ = jrclust.utils.info();
    hFigWav.axApply('default', @title, sprintf('%s v%s; press [H] for help (scale: %0.1f uV)', info_.program, jrclust.utils.version(), maxAmp));
end
