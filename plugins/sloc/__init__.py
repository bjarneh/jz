# python
# -*- coding: utf-8 -*-

import sys

__all__ = ['get_plugin']


def get_plugin():
    """ return a Plugin object"""
    return Plugin()


def slurp_and_sloc(filename):
    with open(filename, 'r') as fd:
        lines = fd.readlines()
    return len(lines)


class Plugin(object):
    """
    Very basic source lines of code (SLOC) counter
    """

    URI = "http://github.com/bjarneh/jz/plugins/sloc"

    def __init__(self):
        self.conf = None
        self.parse = None

    def set_parser(self, pyopt):
        """ Allow you to add your own options (str/bool)"""
        self.parse = pyopt
        self.parse.add_bool("sloc -sloc --sloc")

    def set_config(self, config):
        """ Set config hash, flags have their defaults here, we add ours"""
        self.conf = config
        self.conf['--sloc'] = False

    def argv_parsed(self, rest):
        """ Called more than once, config file is also just parsed
            using same command line parser.
        """
        if self.parse.is_set("--sloc"): self.conf['--sloc'] = True

    def help_flags(self):
        """ Document yourself """
        return "  --sloc        : Count lines of code in your Java project"

    def get_files(self, files):
        """ Which files have been selected for compilation """
        #print("sloc.Plugin.get_files(\n  {})".format('\n  '.join(files)))
        total = 0; max_len = 0
        for f in files:
            lines = slurp_and_sloc(f)
            print("%10d: %s" % (lines, f))
            total += lines
            if len(f) > max_len:
                max_len = len(f)
        print("%10d: %s" % (total, (max_len * '=')))
        sys.exit(0)

    def __str__(self):
        return "sloc.Plugin"
