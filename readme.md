
## Building WRFHydro on Ubuntu 16.04 (Xenial)  

### 1. Install Prerequisites  

Update the cache  

```
$ apt-get update  
```

Install libraries  

```
$ apt-get install -yq --no-install-recommends wget  bzip2 ca-certificates \ 
        vim libhdf5-dev gfortran m4 make libswitch-perl mich libopenmpi-dev 
```

### 2. Install NetCDF-C  

Download NetCDF 4.4.1.1 into the `/tmp` directory and extract it

```
$ wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.4.1.1.tar.gz -P /tmp
$ tar -xf /tmp/netcdf-4.4.1.1.tar.gz -C /tmp
```

Set environment variables necessary for the build  

```
$ H5DIR=/usr/lib/x86_64-linux-gnu/hdf5/serial
$ NCDIR=/usr/local
```

Configure the build for  `/usr/local`
```
$ cd /tmp/netcdf-4.4.1.1
$ CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=/usr/local
```

Execute the build process  
```
$ make
$ make install
```

Test the installation  
```
$ make test
```

### 3. Install NetCDF-Fortran

Download NetCDF 4.4.4 into the `/tmp` directory and extract it  
```
$ wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz
$ tar -xf netcdf-fortran-4.4.4.tar.gz -C /tmp
```

Set environment variables necessary for the build  
```
$ NFDIR=/usr/local
$ LD_LIBRARY_PATH=${NCDIR}/lib
```

Configure the build for  `/usr/local`  
```
$ cd /tmp/netcdf-fortran-4.4.4/ 
$ CPPFLAGS=-I${NFDIR}/include LDFLAGS=-L${NFDIR}/lib ./configure --prefix=${NFDIR}
```

Execute the build process  
```
$ make
$ make install
```

Test the installation  
```
$ make test  
```


### 4. Install the National Water Model  

Download the NWM v1.2 source code and extract it  

```
$ cd ~
$ wget http://public.cuahsi.org/nwm/wrf-hydro-nwm-1.2.tar.gz
$ tar -xf wrf-hydro-nwm-1.2.tar.gz
```

Set environment variables necessary for the build  
```
$ NETCDF=/usr/local
```

Execute the build process  
```
$ cd wrf_hydro_nwm/trunk/NDHMS 
$ ./configure 6
$ ./compile_offline_NoahMP.sh
```

5. Run a sample simulation  

Download and extract the NWM examples  

```
$ wget http://public.cuahsi.org/nwm/wrfHydroTestCases.tar.gz
$ tar -xf wrfHydroTestCases.tar.gz
```

Symlink the executable to the simulation directory  
```
$ cd wrfHydroTestCases/BigThompson/run.Sep2013Flood/
$ ln -sf ~/wrf_hydro/trunk/NDHMS/Run/wrf_hydro.exe .
```

Execute the simulation  
```
$ mpiexec -n 1 ./wrf_hydro.exe
```
