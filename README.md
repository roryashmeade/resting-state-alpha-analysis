# Alpha Power Analysis

This repository contains a MATLAB script for computing alpha-band power from EEG data using FieldTrip.

## Overview

The script:
- computes power spectra with `ft_freqanalysis`
- extracts alpha-band power in the 8–13 Hz range
- separates results by resting state condition
- saves the results to a MAT file

## Requirements

- MATLAB
- FieldTrip
- Preprocessed EEG data in `data_cl`
- Workspace variables:
  - `fpath.preproc`
  - `base`

## Usage

1. Load your preprocessed EEG data into MATLAB.
2. Make sure FieldTrip is on the MATLAB path.
3. Run `alpha_power_analysis.m`.

## Output

The script:
- creates power spectrum figures
- saves alpha-power results as a MAT file named like:
  `*_desc-alphaPower_eeg.mat`

## Notes

- The script expects `trialinfo(:,1)` to encode resting state labels:
  - `1` for RS1
  - `2` for RS2

## License

See the `LICENSE` file for terms of use.
