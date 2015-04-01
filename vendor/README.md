Vendor Directory
================

This directory is for LaTeX packages that we are using that are not present or up-to-date in the full TeXLive installation on EOS. The full TeXLive installation was installed with:

    yum install texlive-*

In general, we put the generated files in here.

An updated version of minted is included to get support for `kpsewhich`, which really helps with Waf.

A `biber` GNU/Linux executable x86_64 is included since `biber` is not installed on EOS. It is only used if `biber` is not found on the `PATH`. The executable was download from [here](http://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/1.9/binaries/Linux/biber-linux_x86_64.tar.gz).
