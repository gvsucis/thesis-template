# -*- coding: utf-8 -*-

"""Open various filetypes."""

import os
import platform

from waflib.Configure import conf

SYSTEM = platform.system()

OPEN_PROG = {
    'Linux': 'xdg-open',
    'Darwin': 'open',
}


def configure(ctx):
    try:
        ctx.find_program(OPEN_PROG[SYSTEM], var='OPEN', mandatory=False)
    except KeyError:
        pass


@conf
def open_file(self, node):
    """Open a node in operating system's associated program."""
    path = node.abspath()
    if self.env.OPEN:
        self.exec_command(
            self.env.OPEN + [path],
            # Don't buffer the program's output. On GNU/Linux, buffering
            # xdg-open's output causes it to block the Waf process.
            stdout=None, stderr=None)
    elif SYSTEM == 'Windows':
        os.startfile(path)
    else:
        try:
            msg = "'{}' not found".format(OPEN_PROG[SYSTEM])
        except KeyError:
            msg = 'platform unsupported'
        self.fatal('Opening file failed, ' + msg)
