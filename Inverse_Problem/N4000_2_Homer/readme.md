# N4000_2_Homer Toolbox

N4000_2_Homer is a open source MATLAB toolbox used for converting the raw .csv N4000 output file into a .nirs file for use with Homer3 Toolbox. The toolbox also requires a .pos file and a .mlist file.

## Installation

N4000_2_Homer is composed only of MATLAB scripts, so the installation process for MATLAB users is as simple as downloading the code. After you install N4000_2_Homer, you can simply start N4000_2_Homer GUI from the MATLAB command window by running:

```
N4000_2_Homer
```

Then, select the target .csv file, .pos file and .mlist file to start the conversion.

![](https://raw.githubusercontent.com/posvirus/Image_storage/main/Snipaste_2023-02-16_23-35-16.png)

## File Formats

### .csv File (Raw Data)

.csv file contains the raw data measured by N4000 device, the raw data for each channel should contain two columns, the first column for the measure time point corresponding to the data and the second column for the raw data value.

In addition, the last column of .csv file will be used to specify the time point when the stimulus occurs and the type of stimulus.

### .pos File (Position Data)

.pos file contains an array of probe coordinates of the source/detector with dimensions, \<number of channels\> by 4, the meaning of the 4 columns are as follows: 

1. **Column 1:** the x coordinates of the source/detector.
2. **Column 2:** the y coordinates of the source/detector.
3. **Column 3:** the z coordinates of the source/detector.
4. **Column 4:** the labels used to distinguish source/detector, 1 refers to the detector and 2 refers to the source.

###.mlist File (Measure List Data)

.mlist file contains an array of source/detector/wavelength measurement channels with dimensions, \<number of channels\> by 5, the meaning of the 5 columns are as follows:

1. **Column 1:** index of the source from the .pos file.
2. **Column 2:** index of the detector from the .pos file.
3. **Column 3:** unused, contains all ones.
4. **Column 4:** index of the wavelength.
5. **Column 5:** the wavelength corresponding to the index.

In addition, it should be noted that the order of channels should be the same as the order in the raw data.

## Output Files

After converting the raw .csv N4000 output file with N4000_2_Homer, a .nirs file will be generated automatically in the same path as the .csv file.
