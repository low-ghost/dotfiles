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
from textwrap import dedent


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-f', '--file', help='file to execute',
                        type=argparse.FileType('r'))
    parser.add_argument('-e', '--environment', nargs='?',
                        choices=['p', 's', 'd'], default='s',
                        help='environment for execution')
    parser.add_argument('-u', '--user', nargs='?',
                        help='override environment based user')
    parser.add_argument('-d', '--db', nargs='?',
                        help='override environment based db')
    parser.add_argument('-l', '--location', nargs='?',
                        help='override environment based location (host)')
    parser.add_argument('-b', '--bash', action='store_true',
                        help='used for hacky bash interop only (used by pgx script)')
    parser.add_argument('-v', '--variables', nargs='+',
                        help='list of variables to replace $1 style prepared arguments')
    parser.add_argument('-p', '--print', action='store_true',
                        help='print the sql itself')
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


def make_replacements(variables, text):
    for i, v in enumerate(variables, 1):
         string_key = '${}'.format(i)
         text = text.replace(string_key, str(v))
    return text


def main():
    args = get_args()

    sql = (args.file and args.file.read()) or args.sql or None

    enter_pg_directly = sql is None

    # Probably, the invoking script will re-invoke the script without --bash but
    # otherwise the same args. We're exiting early to say, 'you can use pgx.py
    # as is and not worry about stdin/out oddities'
    if args.bash and not enter_pg_directly:
        return print('continue')

    # If values are provided in args, assign them to the retrieved env
    # dictionary, otherwise, keep the retrieved values
    initial_env_dict = get_env(args.environment)
    to_assign = {'h': args.location, 'u': args.user, 'd': args.db}
    env_dict = {
        **initial_env_dict,
        **{k: v for k, v in to_assign.items() if v is not None }}

    psql_command = 'psql -h {h} -U {u} -d {d}'.format(**env_dict)

    if enter_pg_directly:
        # Bash will want the command to get into the db
        if args.bash:
            return print(psql_command)
        # Use at own risk. This is why all the bash jumping around
        return run([psql_command], shell=True)

    replaced_sql = make_replacements(args.variables, sql)
    command = ('{} -t << EOF\n'
               'SELECT array_to_json(array_agg(row_to_json(fooo)))'
               'FROM ({}) AS fooo'
               '\nEOF'.format(psql_command, replaced_sql))

    if args.print:
        return print(replaced_sql)

    result = run([command], stdout=PIPE, shell=True)

    # Bit of a hack, but if file is provided, then first positional arg is jq
    jq = args.sql or '.' if args.file else args.jq
    p = Popen(['jq', jq], stdin=PIPE)
    return p.communicate(input=result.stdout)

main()
exit(0)
