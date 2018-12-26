#! /usr/bin/env python
from __future__ import print_function  # pylint: disable=unused-import

name = 'igloo-doc'
default_command = 'click-igloodoc'
entry_points = {
    'console_scripts': [
        '{}=clickable.click:main'.format(default_command)
    ]
}
bootstrap_sh = "https://raw.githubusercontent.com/lalmeras/bootstrap-virtualenv/master/bootstrap.sh"
bootstrap_target = ".tools/bootstrap"
bootstrap_requirements = "git+https://github.com/lalmeras/clickable.git@v0.2.0"

# use local version of bootstrap & clickable
#bootstrap_sh = "file:/home/lalmeras/git/bootstrap-virtualenv/bootstrap.sh"
#bootstrap_requirements = "git+file:/home/lalmeras/git/clickable/@dev"
#bootstrap_requirements = "-efile:/home/lalmeras/git/clickable/"

def bootstrap_done(bootstrapenv):
    print("""
**
** activate environment with
. {0}
{1} --help
**
** Use {1} instead of ./task.py
**""".format(bootstrapenv.activate, default_command))


## Bootstrap clickable ##
## do not modify       ##
import contextlib, os, os.path, shutil, subprocess, sys, tempfile
import os

def prevent_loop(environ, env_name):
    environ = dict(environ)
    if env_name in environ:
        print('** bootstrap loop detected; bootstrap environment installed but unable to load clickable. Aborting...')
        sys.exit(1)
    environ[env_name] = 'true'
    return environ

clean = '--clean' in sys.argv
bootstrap_phase = 'CLICKABLE_BOOTSTRAP' in os.environ
is_main = __name__ == '__main__'
if is_main or bootstrap_phase:
    # block for ./script.py invocation OR import during bootstrap_phase
    if '--help' in sys.argv or '-h' in sys.argv:
        # print usage
        print("""Usage: {0} [--help|-h] [--clean]
Install a virtualenv with minimal requirements ({1})""".format(__file__, bootstrap_requirements))
        sys.exit(0)
    if is_main and (clean or not os.path.exists(bootstrap_target)):
        # download and run bootstrap.sh on missing target, or explicit clean
        environ = prevent_loop(os.environ, 'BOOTSTRAP_INSTALL')
        environ['BOOTSTRAP_TARGET'] = bootstrap_target
        environ['BOOTSTRAP_REQUIREMENTS'] = bootstrap_requirements
        try:
            import urllib2 as urlreq # Python 2.x
        except:
            import urllib.request as urlreq # Python 3.x
        req = urlreq.Request(bootstrap_sh)
        (fd, script) = tempfile.mkstemp()
        with open(script, 'w') as dest, \
             contextlib.closing(urlreq.urlopen(req)) as src:
            shutil.copyfileobj(src, dest)
        subprocess.check_call(['bash', script], env=environ)
    else:
        try:
            # either pip install or python setup.py handling
            from clickable.bootstrap import run_setup
            run_setup(__file__, name, entry_points=entry_points, callback=bootstrap_done)
            raise Exception('unreachable code')
        except ImportError:
            pass
    # rerun script with venv interpreter after install or import failure
    command = list(sys.argv)
    command.insert(0, os.path.join(bootstrap_target, 'bin/python'))
    '--clean' not in command or command.remove('--clean') # clean must not be looped
    environ = prevent_loop(os.environ, 'BOOTSTRAP_RERUN')
    os.execve(command[0], command, environ)
## Bootstrap clickable ##
import json
import logging
import os
import pprint
import re
import subprocess

try:  # py3
    from shlex import quote
except ImportError:  # py2
    from pipes import quote

import click
from ruamel.yaml import YAML

import clickable.utils
import clickable.sphinx
import clickable.coloredlogs


clickable.coloredlogs.bootstrap()
logger = logging.getLogger('clickable')


@click.group()
@click.pass_context
def click_igloodoc(ctx):
    ctx.obj = {}
    path_resolver = clickable.utils.PathResolver(sys.modules[__name__])
    ctx.obj['path_resolver'] = path_resolver
    ctx.obj['project_root'] = \
        os.path.normpath(os.path.dirname(sys.modules[__name__].__file__))
    conf_path = os.path.join(ctx.obj['project_root'], 'clickable.yaml')
    if os.path.isfile(conf_path):
        with open(conf_path) as f:
            yaml = YAML(typ='safe')
            configuration = yaml.load(f)
            ctx.obj.update(configuration)
    logger.info('loaded configuration: \n{}'.format(pprint.pformat(ctx.obj)))
    pass


@click_igloodoc.group()
@click.pass_context
def sphinx(ctx):
    pass


sphinx_provider = lambda ctx: ctx.obj['sphinx']
clickable.sphinx.sphinx_click_group(sphinx, sphinx_provider)
