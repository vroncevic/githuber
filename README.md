# Generate setup script and github guideline file.

githuber is shell tool for generating github structure.

Developed in bash code: 100%.

The README is used to introduce the modules and provide instructions on
how to install the modules, any machine dependencies it may have and any
other information that should be provided before the modules are installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/githuber.svg)](https://github.com/vroncevic/githuber/issues)
 [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/githuber.svg)](https://github.com/vroncevic/githuber/graphs/contributors)

### INSTALLATION

Navigate to release [page](https://github.com/vroncevic/githuber/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf githuber-x.y.z.tar.gz
cd githuber-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/githuber/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/githuber/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/githuber/ver.1.0/
```

Or You can use docker to create image/container.

:sparkles:

### USAGE

```
# Create symlink for shell tool
ln -s /root/scripts/githuber/ver.1.0/bin/githuber.sh /root/bin/githuber

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating github structure
githuber avr_dragon
```

### DEPENDENCIES

This module requires these other modules and libraries:

* sh_util https://github.com/vroncevic/sh_util

### SHELL TOOL STRUCTURE

githuber is based on MOP.

Shell tool structure:
```
.
├── bin/
│   └── githuber.sh
├── conf/
│   ├── githuber.cfg
│   ├── githuber_util.cfg
│   └── template
│       ├── githuber_guideline.template
│       └── githuber_setup.template
└── log/
    └── githuber.log
```

### DOCS

[![Documentation Status](https://readthedocs.org/projects/githuber/badge/?version=latest)](https://githuber.readthedocs.io/projects/githuber/en/latest/?badge=latest)

More documentation and info at:

* https://githuber.readthedocs.io/en/latest/

:sparkles:

### COPYRIGHT AND LICENCE

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2018 by https://vroncevic.github.io/githuber

This tool is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

:sparkles:

