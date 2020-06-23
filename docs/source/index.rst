GITHUBER
---------

.. toctree::
 :hidden:

 self

**githuber** is shell tool for generating github structure.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

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

INSTALLATION
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/githuber/releases

To install **githuber** type the following:

.. code-block:: bash

   tar xvzf githuber-x.y.z.tar.gz
   cd githuber-x.y.z
   cp -R ~/sh_tool/bin/   /root/scripts/githuber/ver.1.0/
   cp -R ~/sh_tool/conf/  /root/scripts/githuber/ver.1.0/
   cp -R ~/sh_tool/log/   /root/scripts/githuber/ver.1.0/

DEPENDENCIES
-------------

**githuber** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

SHELL TOOL STRUCTURE
---------------------

**githuber** is based on MOP.

Code structure:

.. code-block:: bash

   .
   ├── bin/
   │   └── githuber.sh
   ├── conf/
   │   ├── githuber.cfg
   │   ├── githuber_util.cfg
   │   └── template/
   │       ├── githuber_guideline.template
   │       └── githuber_setup.template
   └── log/
       └── githuber.log

COPYRIGHT AND LICENCE
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 by `vroncevic.github.io/githuber <https://vroncevic.github.io/githuber>`_

This tool is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

