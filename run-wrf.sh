#!/bin/bash

# symlink the wrf-hydro binary into the simulation space
ln -sf /home/cuahsi/wrf_hydro_nwm/trunk/NDHMS/Run/wrf_hydro.exe /wrf-exec/${WRFSIM}/wrf_hydro.exe

# run wrf hydro
cd /wrf-exec/${WRFSIM} && mpiexec -n 1 ./wrf_hydro.exe
