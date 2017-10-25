
# GFRmeasure
A Matlab implementation for semi automatic calculation of half-life for glomerular filtration rate (GFR).

## Installation
GFRmeasure can run on Windows and Ubuntu operating systems. In each, GFRmeasure can be installed either through a web installer or the user has to download the MATLAB runtime manually first, install it, and then execute the file in the corresponding folder. Please clone this entire project as the first step.

### Windows 
- option 1: execute the [Windows_installer.exe](Windows_installer.exe) file which will download the appropriate MATLAB runtime on its own and install the software as a program. Then just start the GFRmeasure.
- option 2: first download [MATLAB runtime v9.1]( https://de.mathworks.com/supportfiles/downloads/R2016b/deployment_files/R2016b/installers/win64/MCR_R2016b_win64_installer.exe) then execute [GFRmeasure.exe](Windows/GFRmeasure.exe).

### Linux
- option 1: execute the [Linux_installer.install](Linux_installer.install) file which will download the appropriate MATLAB runtime on its own and install the software as a program. Then just start the GFRmeasure.
- option 2: first download [MATLAB runtime v9.3](http://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip) and install it. Then execute the following in a command shell: 
```
cd Linux
./GFRmeasure.sh 'PATH-TO-THE-INSTALL-DIR-OF-MATLAB-RUNTIME'
```
with PATH-TO-THE-INSTALL-DIR-OF-MATLAB-RUNTIME being the folder in which the MATLAB runtime has been installed to including the folder with the version name. For example: 
```
./GFRmeasure.sh /usr/local/MATLAB/MATLAB_Runtime/v91
```

