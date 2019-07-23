#! /bin/env python
# -*- encoding: utf-8 -*-
import json
import logging
import os
import pprint
import re
import subprocess
import sys

try:  # py3
    from shlex import quote
except ImportError:  # py2
    from pipes import quote

import click
from ruamel.yaml import YAML

import clickable.utils
import clickable.sphinx
import clickable.coloredlogs
import clickable.syncing


clickable.coloredlogs.bootstrap()
logger = logging.getLogger('clickable')


@click.group()
@click.pass_context
def main(ctx):
    ctx.obj = {}
    path_resolver = clickable.utils.PathResolver(sys.modules[__name__])
    ctx.obj['path_resolver'] = path_resolver
    ctx.obj['project_root'] = \
        os.path.normpath(os.path.dirname(sys.modules[__name__].__file__))
    conf_path = os.path.join(ctx.obj['project_root'], 'clickables.yml')
    if os.path.isfile(conf_path):
        with open(conf_path) as f:
            yaml = YAML(typ='safe')
            configuration = yaml.load(f)
            ctx.obj.update(configuration)
    logger.info('loaded configuration: \n{}'.format(pprint.pformat(ctx.obj)))
    pass


@main.group()
@click.pass_context
def sphinx(ctx):
    pass


sphinx_provider = lambda ctx: ctx.obj['sphinx']
path_provider = lambda ctx: ctx.obj['path_resolver']
clickable.sphinx.sphinx_click_group(sphinx, sphinx_provider)
