#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Just a simple wrapper around psql including environment based selection of
credentials, execute from file, automatic json formatting, and jq parsing.

To just enter psql environment with credentials, leave out file and sql args.
However, stdin/out are kind of buggy and I'm giving up on direct psql entrance
via this script. Instead, I've deferred it to a bash wrapper calling this
with the --getcommand flag and then executing
"""

import argparse
from os import environ
from subprocess import run, PIPE, Popen
from re import escape, compile


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--file', help='file to execute',
                        type=argparse.FileType('r'))
    parser.add_argument('--environment', nargs='?',
                        choices=['p', 's', 'd'], default='s',
                        help='environment for execution')
    parser.add_argument('--user', nargs='?',
                        help='override environment based user')
    parser.add_argument('--db', nargs='?',
                        help='override environment based db')
    parser.add_argument('--location', nargs='?',
                        help='override environment based location (host)')
    parser.add_argument('--getcommand', action='store_true',
                        help='get command to execute for inspection or later execution')
    parser.add_argument('--variables', nargs='+',
                        help='list of variables to replace ${1} style prepared arguments')
    parser.add_argument('sql', help='sql to execute', nargs='?')
    parser.add_argument('jq', help='jq filter', default='.', nargs='?')
    return parser.parse_args()


def get_env(environment):
    if environment == 's':
        return {'h': environ['PG_HOST_EXM'], 'u': environ['PG_USER_LOC'],
                'd': 'exm-staging'}
    if environment == 'd':
        return {'h': 'localhost', 'u': environ['PG_USER_LOC'],
                'd': 'exm-development'}
    return {'h': environ['PG_HOST_EXM'], 'u': environ['PG_USER_ME'],
            'd': 'exm-production'}


def get_replacement_dict(variables):
    return { escape('${}'.format(k)): v for k, v in enumerate(variables, 1) }


def make_replacements(variables, text):
    if not variables:
      return text

    replacement_dict = get_replacement_dict(variables)
    pattern = compile("|".join(replacement_dict.keys()))
    return pattern.sub(lambda match: replacement_dict[escape(match.group(0))], text)


def main():
    args = get_args()

    # If values are provided in args, assign them to the retrieved env
    # dictionary, otherwise, keep the retrieved values
    initial_env_dict = get_env(args.environment)
    to_assign = {'h': args.location, 'u': args.user, 'd': args.db}
    env_dict = {
        **initial_env_dict,
        **{k: v for k, v in to_assign.items() if v is not None }}

    psql_command = 'psql -h {h} -U {u} -d {d}'.format(**env_dict)
    sql = (args.file and args.file.read()) or args.sql or None
    # Bit of a hack, but if file is provided, then first positional arg is jq
    jq = args.sql if args.file else args.jq

    if sql is None:
        if args.getcommand:
            return print(psql_command)
        return run([psql_command], shell=True)

    replaced_sql = make_replacements(args.variables, sql)
    command = ('{} -t -c'
               ' "SELECT array_to_json(array_agg(row_to_json(fooo)))'
               ' FROM ({}) AS fooo"'.format(psql_command, replaced_sql))

    if args.getcommand:
        return print('{} | jq {}'.format(command, jq))

    result = run([command], stdout=PIPE, shell=True)
    p = Popen(['jq', jq], stdin=PIPE)
    return p.communicate(input=result.stdout)

main()
