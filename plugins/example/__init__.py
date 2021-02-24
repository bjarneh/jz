# python
# -*- coding: utf-8 -*-

__all__ = ['get_plugin']


def get_plugin():
    """ return a Plugin object"""
    return Plugin()


class Plugin(object):
    """
    Example plugin
    """

    URI = "http://github.com/bjarneh/jz/plugins/example"

    def __init__(self):
        print("example.Plugin.__init__()")
        self.conf = None
        self.parse = None
        self.xtra  = []

    def set_parser(self, pyopt):
        """ Allow you to add your own options (str/bool)"""
        print("example.Plugin.set_parser()")
        self.parse = pyopt
        self.parse.add_bool("--example-flag")

    def set_config(self, config):
        """ Set config hash, flags have their defaults here, we add ours"""
        print("example.Plugin.set_config()")
        self.conf = config
        self.conf['--example-flag'] = False

    def argv_parsed(self, rest):
        """ Called more than once, config file is also just parsed
            using same command line parser.
        """
        print("example.Plugin.argv_parsed()")
        if self.parse.is_set("--example-flag"):
            self.conf['--example-flag'] = True
        self.xtra += rest

    def after_parsing(self, xtra_args):
        """ Now the flag / config file parsing is done """
        print("example.Plugin.after_parsing()")
        if self.conf['--example-flag']:
            print("  --example-flag: True")

    def help_flags(self):
        """ Document yourself """
        print("example.Plugin.help_flags()")
        return "  --example-flag: This flag is given to test example plugin"

    def set_deps(self, libs, classpath):
        print("example.Plugin.set_deps(\n  libs={},\n  classpath={})".format(libs, classpath))

    def get_matcher(self):
        """ Allow override of which files (Java) we look for"""
        print("example.Plugin.get_matcher()")

    def get_files(self, files):
        """ Which files have been selected for compilation """
        print("example.Plugin.get_files(\n  {})".format('\n  '.join(files)))

    def set_pkgs(self, pkgs):
        """ Which packages have we found """
        print("example.Plugin.set_pkgs({})".format(pkgs.keys()))

    def build_calculated(self, pkgs):
        print("example.Plugin.build_calculated({})".format(pkgs.keys()))
        for k in pkgs.keys():
            print("  {} [ compile? ] => {}".format(k, pkgs[k].make))

    def __str__(self):
        return "example.Plugin"
