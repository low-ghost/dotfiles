import vim
import json
import re
from subprocess import Popen, PIPE
from typing import List, Tuple, Dict, Any


class Printer:

    def __init__(self) -> None:
        self.collated = ''

    def write(self, text: str) -> None:
        self.collated = '{}\n{}'.format(self.collated, text)
        print(text)

    def set_vim_var(self) -> None:
        if self.collated is not None:
            vim.vars['last_flow_type'] = self.collated


def get_initial_vars() -> Tuple[int, int, List[str], str, Printer]:
    current = vim.current
    line_num, col_num = current.window.cursor
    flow_bin = vim.vars['flow#flow_path'] or 'flow'
    return (line_num, col_num, current.buffer, flow_bin, Printer())


def get_flow_command(flow_bin: str, line_num: int, col_num=1) -> List[str]:
    return [flow_bin, 'type-at-pos', '--json', str(line_num),
            str(col_num + 1)]


def decode_json_load(result: bytes) -> Dict[str, Any]:
    return json.loads(result.decode('utf-8'))


def execute_with_input(command: List[str], input: str) -> Dict[str, Any]:
    process = Popen(command, stdout=PIPE, stdin=PIPE)
    command_results = process.communicate(input=str.encode(input))[0]
    if process.returncode != 0:
        raise Exception('An error occurred with the flow executable')
    return decode_json_load(command_results)


def get_initial_type(flow_bin: str, line_num: int, col_num: int,
                     buf: List[str]) -> str:
    command = get_flow_command(flow_bin, line_num, col_num)
    buf_joined = '\n'.join(buf[:])
    flow_results = execute_with_input(command, buf_joined)
    return flow_results['type']


def get_secondary_type(flow_bin: str, line_num: int, buf: List[str],
                       name: str) -> str:
    reduced_line = '{' + name + '}'
    reduced_buf = '\n'.join(buf[:line_num]
                            + [reduced_line]
                            + buf[line_num + 1:])
    sub_command = get_flow_command(flow_bin, line_num + 1)
    flow_results = execute_with_input(sub_command, reduced_buf)
    return flow_results['type']


def is_react(element_type):
    return 'React$Element' in element_type


def get_wrapping_jsx(buf: List[str], line_num: int, col_num: int, index=0
                     ) -> Tuple[Tuple[int, str], int]:
    line_num_to_search = line_num - 1 - index
    if line_num_to_search < 0:
        return ((None, None), None)
    # TODO: if on closing tag, like </div> here: <div><Something /></div>
    line_text = buf[line_num_to_search]
    starts_and_names = [(m.start(), m.group(1))
                        for m in re.finditer(r'<(\w+)', line_text)
                        if not col_num or m.start() <= col_num]
    index += 1
    return ((starts_and_names[-1], line_num_to_search) if starts_and_names
            else get_wrapping_jsx(buf, line_num, None, index))


def parse_type_end_pos(after_key: str) -> int:
    token_to_regex = {
        'word': '\w+',
        'openings': '<|\{|\[',
        'closings': '>|\}|\]',
        'func_init': '\(.*?=>',
    }
    token_regex = '|'.join('(?P<{}>{})'.format(k, v)
                           for k, v in token_to_regex.items())

    last_pos = None
    checking_generic = False
    openings = 0
    closings = 0
    for m in re.finditer(token_regex, after_key):
        kind = m.lastgroup
        value = m.group(kind)
        if kind == 'word':
            last_found_was_a_word = checking_generic
            if last_found_was_a_word:
                return last_pos
            last_pos = m.end()
            checking_generic = True
            continue
        type_is_just_a_word = (checking_generic and value != '<'
                               and openings == closings)
        if type_is_just_a_word:
            return last_pos
        if kind == 'openings':
            openings += 1
        if kind == 'closings':
            closings += 1
        if closings == openings and openings != 0:
            last_pos = m.end()
            return last_pos


def attempt_prop_lookup(type_to_search: str, printer: Printer) -> None:
    current_word = vim.eval("expand('<cword>')")
    pos_of_key = re.search('{}(\?)?:\s(.*)'.format(current_word),
                           type_to_search)
    if not pos_of_key:
        return None
    optional_mark = '?' if pos_of_key.group(1) else ''
    after_key = pos_of_key.group(2)
    last_pos = parse_type_end_pos(after_key)

    if last_pos is None:
        return None

    printer.write('prop: {}{}: {}'.format(current_word, optional_mark,
                                          after_key[:last_pos]))


def main() -> None:
    line_num, col_num, buf, flow_bin, printer = get_initial_vars()
    parent_type = get_initial_type(flow_bin, line_num, col_num, buf)
    printer.write(parent_type)

    if is_react(parent_type):
        [start, name], line_of_match = get_wrapping_jsx(buf, line_num, col_num)
        if start is not None:
            printer.write('element-name: {}'.format(name))
            sub_type = get_secondary_type(flow_bin, line_of_match, buf, name)
            sub_is_react = is_react(sub_type)

            # Element type is not reliable for built in jsx elements like div
            if sub_is_react:
                printer.write('element-type: {}'.format(sub_type))

            type_to_search = sub_type if sub_is_react else parent_type
            attempt_prop_lookup(type_to_search, printer)

    printer.set_vim_var()


main()
