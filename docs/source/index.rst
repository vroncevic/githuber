githuber
---------

**githuber** is shell tool for generating github structure.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/githuber/actions/workflows/githuber_shell_checker.yml/badge.svg
   :target: https://github.com/vroncevic/githuber/actions/workflows/githuber_shell_checker.yml

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/githuber.svg
   :target: https://github.com/vroncevic/githuber/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/githuber.svg
   :target: https://github.com/vroncevic/githuber/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/githuber/badge/?version=latest
   :target: https://githuber.readthedocs.io/projects/githuber/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

|Debian Linux OS|

.. |Debian Linux OS| image:: https://raw.githubusercontent.com/vroncevic/githuber/dev/docs/debtux.png
   :target: https://www.debian.org

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/githuber/releases

To install **githuber** type the following

.. code-block:: bash

   tar xvzf githuber-x.y.tar.gz
   cd githuber-x.y
   cp -R ~/sh_tool/bin/   /root/scripts/githuber/ver.x.y/
   cp -R ~/sh_tool/conf/  /root/scripts/githuber/ver.x.y/
   cp -R ~/sh_tool/log/   /root/scripts/githuber/ver.x.y/

Or You can use Docker to create image/container.

Dependencies
-------------

**githuber** requires next modules and libraries

* sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**githuber** is based on MOP.

Shell tool structure

.. code-block:: bash

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

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2017 - 2024 by `vroncevic.github.io/githuber <https://vroncevic.github.io/githuber>`_

**githuber** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

|Free Software Foundation|

.. |Free Software Foundation| image:: https://raw.githubusercontent.com/vroncevic/githuber/dev/docs/fsf-logo_1.png
   :target: https://my.fsf.org/

|Donate|

.. |Donate| image:: https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif
   :target: https://my.fsf.org/donate/

Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
