# Thesis Template

This is a template for a Master of Computing and Information Systems thesis at Grand Valley State University.

## Getting Started: Linux

If you are using a Linux computer (such as one provided in the 
[EOS labs](http://www.cis.gvsu.edu/eosarchitecture-labs/)), first create and move into a directory
of your choice.  Then type at the command-line

    git clone https://github.com/gvsucis/thesis-template
    
to clone the thesis template to a `thesis-template` directory.  Move into this directory and 
execute the commands:

    pip install --user -r requirements.txt
    ./waf configure
    ./waf build

These commands will install requirements, configure and install your LaTeX environment, and then 
build the included sample thesis. If you execute 

    ./waf open

it will open and display the corresponding PDF. Alternatively the PDF (and all associated logfiles 
and auxiliary files) can be found in the subdirectory called `build`. 

## Getting Started: Windows

If you don't already have Python on your machine, 
[download and install Python](https://www.python.org/downloads/windows/).  During installation, make
sure to add the Python directories to the Window `PATH` environmental variable.  It might also be 
useful to [download and install MiKTEX](https://miktex.org/download). Obtain a copy of the thesis 
template by executing

    git clone https://github.com/gvsucis/thesis-template
    
in a directory of your choice, or by downloading a zipped copy of the repository from GitHub and 
extracting it on your computer.  Open a command prompt in the newly created `thesis-template`
directory.  (A convenient method is to SHIFT+{right click} on the folder and to select 
`Open command window here`).  Afterwards, execute the commands

    pip install --user -r requirements.txt
    python waf configure
    python waf build

These commands will install requirements, configure and install your LaTeX environment, and then 
build the included sample thesis. If you execute 

    python waf open

it will open and display the corresponding PDF. Alternatively the PDF (and all associated logfiles 
and auxiliary files) can be found in the subdirectory called `build`. 

## Completing Your Thesis

Information on forms you will need for your thesis can be found in the [ogs-forms](ogs-forms) 
directory.

# FAQ

## Resolving errors with `minted` and `pygmentize` on Windows

Using a technique similar to that proposed on the 
[Tex StackExchange site](http://tex.stackexchange.com/questions/23458/how-to-install-syntax-highlight-package-minted-on-windows-7),
consider placing the following file at the location `{PYTHON_INSTALL}\Scripts\pygmentize.cmd`

    @echo off
    %APPDATA%\Python\Python36\Scripts\Pygmentize %*
    
Note, in the above script replace the `Python36` with a version appropriate for your installation.