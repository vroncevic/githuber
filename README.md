<img align="right" src="https://raw.githubusercontent.com/vroncevic/githuber/dev/docs/githuber_logo.png" width="25%">

# Generate setup scripts and github guideline file

**githuber** is shell tool for generating github structure.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![githuber shell checker](https://github.com/vroncevic/githuber/workflows/githuber%20shell%20checker/badge.svg)](https://github.com/vroncevic/githuber/actions?query=workflow%3A%22githuber+shell+checker%22)

The README is used to introduce the modules and provide instructions on
how to install the modules, any machine dependencies it may have and any
other information that should be provided before the modules are installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/githuber.svg)](https://github.com/vroncevic/githuber/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/githuber.svg)](https://github.com/vroncevic/githuber/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/githuber/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/githuber/releases)** download and extract release archive.

To install **githuber** type the following

```
tar xvzf githuber-x.y.tar.gz
cd githuber-x.y
cp -R ~/sh_tool/bin/   /root/scripts/githuber/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/githuber/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/githuber/ver.x.y/
```

Self generated setup script and execution
```
./githuber_setup.sh 

[Setup] Installing App/Tool/Script githuber
	Sat 20 Nov 2021 08:51:28 AM CET
[Setup] Clean up App/Tool/Script structure
[Setup] Copy App/Tool/Script structure
[Setup] Remove github editor configuration files
[Setup] Set App/Tool/Script permission
[setup] Create symbolic link of App/Tool/Script
[Setup] Done

/root/scripts/githuber/ver.3.1/
├── bin
│   ├── center.sh
│   ├── deploy_build_py.sh
│   ├── deploy_codecov.sh
│   ├── deploy_docker.sh
│   ├── deploy_guide.sh
│   ├── deploy_setup.sh
│   ├── deploy_venv.sh
│   ├── display_logo.sh
│   ├── drop_to_file.sh
│   └── githuber.sh
├── conf
│   ├── githuber.cfg
│   ├── githuber.logo
│   ├── githuber_util.cfg
│   └── template
│       ├── docker_create_container.template
│       ├── docker_create_image.template
│       ├── docker_push_image.template
│       ├── docker_remove_container.template
│       ├── docker_remove_image.template
│       ├── docker_stop_container.template
│       ├── githuber_guideline.template
│       ├── githuber_setup_py.template
│       ├── githuber_setup_sh.template
│       ├── pypi2_build.template
│       ├── pypi3_build.template
│       ├── pypi_create.template
│       ├── pypi_deploy.template
│       ├── update_codecov.template
│       ├── venv_create.template
│       └── venv_helper.template
└── log
    └── githuber.log

4 directories, 30 files
lrwxrwxrwx 1 root root 46 Nov 20 08:51 /root/bin/githuber -> /root/scripts/githuber/ver.3.1/bin/githuber.sh
```

Or You can use docker to create image/container.

[![githuber docker checker](https://github.com/vroncevic/githuber/workflows/githuber%20docker%20checker/badge.svg)](https://github.com/vroncevic/githuber/actions?query=workflow%3A%22githuber+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/githuber/ver.x.y/bin/githuber.sh /root/bin/githuber

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating github structure
githuber python test
                                                                                                                                                                        
githuber ver.3.1
Sat 20 Nov 2021 08:56:38 AM CET

[check_root] Check permission for current session? [ok]
[check_root] Done

			       _ _   _           _               
			  ___ (_) |_| |__  _   _| |__   ___ _ __ 
			 / _ \| | __| '_ \| | | | '_ \ / _ \ '__|
			| (_| | | |_| | | | |_| | |_) |  __/ |   
			 \__/ |_|\__|_| |_|\___/|_.__/ \___|_|   
			 |___/ 
					Info   github.io/githuber ver.3.1 
					Issue  github.io/issue
					Author vroncevic.github.io

[githuber] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/githuber/ver.3.1/conf/githuber.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/githuber/ver.3.1/conf/githuber_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[githuber] Checking directory [/data/dev/]? [ok]
[githuber] Checking directory [/data/dev/python/]? [ok]
[githuber] Generating directory [/data/dev/python/test/]
[githuber] Generating file [/data/dev/python/test/test_setup.sh]
[githuber] Generating file [/data/dev/python/test/test_git.txt]
[githuber] Generating directory [/data/dev/python/test/docs/]
[githuber] Generating directory [/data/dev/python/test/github/]
[githuber] Generating directory [/data/dev/python/test/github/test//]
[githuber] Generating file [/data/dev/python/test/github/docker_create_image.sh]
[githuber] Generating file [/data/dev/python/test/github/docker_create_container.sh]
[githuber] Generating file [/data/dev/python/test/github/docker_push_image.sh]
[githuber] Generating file [/data/dev/python/test/github/docker_stop_container.sh]
[githuber] Generating file [/data/dev/python/test/github/docker_remove_container.sh]
[githuber] Generating file [/data/dev/python/test/github/docker_remove_image.sh]

	==============================
	# [1] Python 2
	# [2] Python 3
	# [3] Python 2/3
	==============================
	Select Python support option >	3
	Option Python 2 and Python 3 Picked

[githuber] Generating file [/data/dev/python/test/github/pypi_create.sh]
[githuber] Generating file [/data/dev/python/test/github/pypi_deploy.sh]
[githuber] Generating file [/data/dev/python/test/github/pypi2_build.sh]
[githuber] Generating file [/data/dev/python/test/github/pypi3_build.sh]
[githuber] Generating file [/data/dev/python/test/github/venv_create.sh]
[githuber] Generating file [/data/dev/python/test/github/venv_helper.sh]
[githuber] Generating file [/data/dev/python/test/github/update_codecov.sh]
[githuber] Set owner!
[githuber] Set permission!
[logging] Checking directory [/root/scripts/githuber/ver.3.1/log/]? [ok]
[logging] Write info log!
[logging] Done

[githuber] Done

[check_tool] Checking tool [/usr/bin/tree]? [ok]
[check_tool] Done

/data/dev/python/test/
├── docs
├── github
│   ├── docker_create_container.sh
│   ├── docker_create_image.sh
│   ├── docker_push_image.sh
│   ├── docker_remove_container.sh
│   ├── docker_remove_image.sh
│   ├── docker_stop_container.sh
│   ├── pypi2_build.sh
│   ├── pypi3_build.sh
│   ├── pypi_create.sh
│   ├── pypi_deploy.sh
│   ├── test
│   ├── update_codecov.sh
│   ├── venv_create.sh
│   └── venv_helper.sh
├── test_git.txt
└── test_setup.sh

3 directories, 15 files
```

### Dependencies

**githuber** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**githuber** is based on MOP.

Shell tool structure
```
sh_tool/
├── bin/
│   ├── center.sh
│   ├── deploy_build_py.sh
│   ├── deploy_codecov.sh
│   ├── deploy_docker.sh
│   ├── deploy_guide.sh
│   ├── deploy_setup.sh
│   ├── deploy_venv.sh
│   ├── display_logo.sh
│   ├── drop_to_file.sh
│   └── githuber.sh
├── conf/
│   ├── githuber.cfg
│   ├── githuber.logo
│   ├── githuber_util.cfg
│   └── template/
│       ├── docker_create_container.template
│       ├── docker_create_image.template
│       ├── docker_push_image.template
│       ├── docker_remove_container.template
│       ├── docker_remove_image.template
│       ├── docker_stop_container.template
│       ├── githuber_guideline.template
│       ├── githuber_setup_py.template
│       ├── githuber_setup_sh.template
│       ├── pypi2_build.template
│       ├── pypi3_build.template
│       ├── pypi_create.template
│       ├── pypi_deploy.template
│       ├── update_codecov.template
│       ├── venv_create.template
│       └── venv_helper.template
└── log/
    └── githuber.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/githuber/badge/?version=latest)](https://githuber.readthedocs.io/projects/githuber/en/latest/?badge=latest)

More documentation and info at
* [https://githuber.readthedocs.io/en/latest/](https://githuber.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2017 by [vroncevic.github.io/githuber](https://vroncevic.github.io/githuber)

**githuber** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/githuber/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
