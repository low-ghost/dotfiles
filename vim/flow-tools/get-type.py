import vim
import json
import re
from subprocess import Popen, PIPE


def get_flow_command(flow_bin, line_num, col_num=1):
    return [flow_bin, 'type-at-pos', '--json', '--no-auto-start',
            str(line_num), str(col_num + 1)]


def decode_json_load(result):
    return json.loads(result.decode('utf-8'))


def execute_with_input(command, input_str):
    process = Popen(command, stdout=PIPE, stdin=PIPE)
    command_results = process.communicate(input=str.encode(input_str))[0]
    if process.returncode != 0:
        raise Exception('An error occurred with the flow executable')
    return decode_json_load(command_results)


def get_wrapping_jsx(buf, line_num, col_num, index=0):

    line_num_to_search = line_num - 1 - index
    if line_num_to_search < 0:
        return [[None, None], None]
    # TODO: if on </div> here: <div><Here /></div>
    line_text = buf[line_num_to_search]
    starts_and_names = [[m.start(), m.group(1)]
                        for m in re.finditer(r'<(\w+)', line_text)
                        if not col_num or m.start() <= col_num]
    index += 1
    return ([starts_and_names[-1], line_num_to_search] if starts_and_names
            else get_wrapping_jsx(buf, line_num, None, index))


def main():
    current = vim.current
    line_num, col_num = current.window.cursor
    flow_bin = vim.vars['deoplete#sources#flow#flow_bin'] or 'flow'

    command = get_flow_command(flow_bin, line_num, col_num)
    buf_joined = '\n'.join(current.buffer[:])
    results = execute_with_input(command, buf_joined)

    parent_type = results['type']
    if 'React$Element' in parent_type:
        [start, name],  line_num_for_match = (
            get_wrapping_jsx(current.buffer, line_num, col_num))
        if start is not None:
            print('parent: {}\nelement name: {}'.format(parent_type, name))
            reduced_line = '{' + name + '}'
            reduced_buf = '\n'.join(current.buffer[:line_num_for_match]
                                    + [reduced_line]
                                    + current.buffer[line_num_for_match + 1:])
            sub_command = get_flow_command(flow_bin, line_num_for_match + 1)
            sub_command_results = execute_with_input(sub_command, reduced_buf)
            if 'React$Element' in sub_command_results['type']:
                print('type: {}'.format(sub_command_results['type']))
        else:
            print(results['type'])
    else:
        print(results['type'])

main()
