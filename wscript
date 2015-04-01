# -*- mode: python; coding: utf-8; -*-

# Waf build file
# https://code.google.com/p/waf/

import os
import re

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

    # Override biber.
    ctx.find_program(
        'biber',
        # Find biber on the PATH if possible, but fallback to our GNU/Linux
        # x86_64 executable if not found.
        path_list=(ctx.environ.get('PATH', '').split(os.pathsep) +
                   [ctx.path.find_dir('vendor').abspath()]))
    # Include the biber tool. This replaces inclusion of tex tool. It will find
    # biber twice, but... oh well.
    ctx.load('biber')
    ctx.load('open', tooldir='waf-tools')
    # pygmentize is found by minted on the PATH, so it would be misleading to
    # include it here (minted always uses whatever is on the PATH).
    ctx.env.append_value('XELATEXFLAGS', '-shell-escape') # For minted

class OpenContext(waflib.Build.BuildContext):
    """opens the resume PDF"""
    cmd = 'open'

def build(ctx):
    _set_texmf(ctx)

    tex_node = ctx.path.find_resource('thesis.tex')
    pdf_node = tex_node.change_ext('.pdf')
    ctx(features='tex',
        # LuaLaTeX is preferred, but our LuaLaTeX installation is broken on
        # EOS.
        type='xelatex',
        source=tex_node,
        outs='pdf')

    if ctx.cmd == 'open':
        def _open(ctx):
            ctx.open_file(pdf_node)
        ctx.add_post_fun(_open)
