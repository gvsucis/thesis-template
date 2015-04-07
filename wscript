# -*- mode: python; coding: utf-8; -*-

# Waf build file
# https://code.google.com/p/waf/

import os
import re
import sys
import site
from os.path import join as _join

import waflib
from waflib.Tools import tex

# Override the scanner to support our own case. We have added 'includepdf',
# 'inputminted', and 'verbatiminput' to the list of commands, and modified the
# regex to return the last {myfile} as the file (which suits includepdf).
tex.re_tex = re.compile(r'\\(?P<type>usepackage|RequirePackage|include|bibliography([^\[\]{}]*)|putbib|includegraphics|input|import|bringin|lstinputlisting|includepdf|inputminted|verbatiminput)(\[[^\[\]]*\])?(?:{[^{}]*})*{(?P<file>[^{}]*)}', re.M)
# Add more file extensions for which to search.
tex.exts_deps_tex += ['.jpg', '.txt']

def _set_texmf(ctx):
    # Override TEXMFHOME so that our vendored packages can be found. Probably
    # not the cleanest way to do this.
    os.environ['TEXMFHOME'] = ctx.path.find_dir(['vendor', 'texmf']).abspath()

def options(ctx):
    ctx.load('biber') # Replaces inclusion of tex tool

def configure(ctx):
    _set_texmf(ctx)

    orig_path_list = ctx.environ.get('PATH', '').split(os.pathsep)

    # Override biber.
    ctx.find_program(
        'biber',
        # Find biber on the PATH if possible, but fallback to our GNU/Linux
        # x86_64 executable if not found.
        path_list=orig_path_list + [ctx.path.find_dir('vendor').abspath()])
    # Include the biber tool. This replaces inclusion of tex tool. It will find
    # biber twice, but... oh well.
    ctx.load('biber')
    # LuaLaTeX is preferred, but our LuaLaTeX installation is broken on
    # EOS.
    if not ctx.env.XELATEX:
        ctx.fatal("Could not find required program 'xelatex'")
    ctx.load('open', tooldir='waf-tools')
    ctx.find_program(
        'pygmentize',
        path_list=orig_path_list + [_join(site.getuserbase(), 'bin')])
    ctx.env.append_value('XELATEXFLAGS', '-shell-escape') # For minted

class OpenContext(waflib.Build.BuildContext):
    """opens the resume PDF"""
    cmd = 'open'

def build(ctx):
    _set_texmf(ctx)

    shim_dir_name = 'pygmentize-shim'
    shim_dir = ctx.bldnode.find_or_declare(shim_dir_name)
    shim_dir.mkdir()
    shim_dir_path = shim_dir.abspath()
    shim_out_node = shim_dir.find_or_declare('pygmentize')

    ctx(features='subst',
        source='scripts/pygmentize-shim.in',
        target=shim_out_node,
        PYGMENTIZE=repr(ctx.env.PYGMENTIZE[0]),
        ADDED_PATH=repr(shim_dir_path),
        PYTHON=sys.executable,
        chmod=waflib.Utils.O755,
    )

    # TODO: Is this the best way to change the PATH for the tex task?
    os.environ['PATH'] = shim_dir_path + os.pathsep + os.environ.get(
        'PATH', '')

    tex_node = ctx.path.find_resource('thesis.tex')
    pdf_node = tex_node.change_ext('.pdf')
    ctx(features='tex',
        type='xelatex',
        source=tex_node,
        outs='pdf',
        # Since the PDF is built using the shim, it must depend on the shim.
        deps=[shim_out_node])

    if ctx.cmd == 'open':
        def _open(ctx):
            ctx.open_file(pdf_node)
        ctx.add_post_fun(_open)
