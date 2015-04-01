# -*- mode: python; coding: utf-8; -*-

# Waf build file
# https://code.google.com/p/waf/

import re

import waflib
from waflib.Tools import tex

# Override the scanner to support our own case. We have added 'includepdf',
# 'inputminted', and 'verbatiminput' to the list of commands, and modified the
# regex to return the last {myfile} as the file (which suits includepdf).
tex.re_tex = re.compile(r'\\(?P<type>usepackage|RequirePackage|include|bibliography([^\[\]{}]*)|putbib|includegraphics|input|import|bringin|lstinputlisting|includepdf|inputminted|verbatiminput)(\[[^\[\]]*\])?(?:{[^{}]*})*{(?P<file>[^{}]*)}', re.M)
# Add more file extensions for which to search.
tex.exts_deps_tex += ['.jpg', '.txt']

def options(ctx):
    ctx.load('biber') # Replaces inclusion of tex tool

def configure(ctx):
    ctx.load('biber') # Replaces inclusion of tex tool
    ctx.load('open', tooldir='waf-tools')
    # pygmentize is found by minted on the PATH, so it would be misleading to
    # include it here (minted always uses whatever is on the PATH).
    ctx.env.append_value('XELATEXFLAGS', '-shell-escape') # For minted
    # Add directory to the TeX search path so that our vendored minted package
    # can be found.
    ctx.env.TEXINPUTS = ctx.path.find_dir(['vendor', 'minted']).abspath()

class OpenContext(waflib.Build.BuildContext):
    """opens the resume PDF"""
    cmd = 'open'

def build(ctx):
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
