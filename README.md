# clas12-env

### Overview
This repository is a runtime environment setup for CLAS12 software based on [module](https://modules.sourceforge.net/)[files](https://modules.readthedocs.io/en/latest/modulefile.html).  The GEANT4/GEMC portions of this environment are [documented here](https://geant4.jlab.org/node/1) and can be used independently.

### In Use
The main branch is deployed on CVMFS and used for running software at JLab, on the Open Science Grid, or on any supported operating system with CVMFS access:

`module use /cvmfs/oasis.opensciencegrid.jlab.org/jlab/hallb/clas12/sw/modulefiles`

### Special Modules
Most modules here just update one's environment for a single, particular software package, by adding that package's location(s) to some runtime executable/library search path(s).  These modules below are a bit different:
* clas12
  * loads a bunch of other modules to provide a full CLAS12 environment in one shot
* geant4
  * adds the [independent geant4-related modulefiles](https://geant4.jlab.org/node/1), e.g. gemc, to the search path
* tmpfs
  * sets various environment variables to get various software (maven, apptainer, java, things that honor `TMPDIR`, etc.) to use a `/tmp` alternative, e.g. for when it's mounted noexec
* scicomp
  * adds software supported by JLab's scicomp group to the module search path

And these two modules below provide some 3rd-party dependencies installed in a "system-like" location:
* system
  * sets `OSRELEASE` based on the operating system (via [this script](util/osrelease.py))
  * sets `CLAS12_HOME` (only for convenience)
  * sets `PATH`, `LD_LIBRARY_PATH`, and `PKG_CONFIG_PATH` for these C++ libraries:
    * [fmt](https://github.com/fmtlib/fmt)
    * [yaml-cpp](https://github.com/jbeder/yaml-cpp)
* pymods
  * sets `PYTHONPATH` to pickup these pip-installed python packages (and their dependencies):
    * sqlalchemy
    * pymysql
    * ninja
    * jinja
    * meson
    * tzdata
    * numpy
    * pandas
