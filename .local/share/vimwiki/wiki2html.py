#!/usr/bin/env python3
# Vimwiki to HTML converter
# Copyright (C) 2021 Oscar Benedito
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import os
import re
import sys
import datetime
import markdown


def get_file_metadata_and_text(file, wiki_path, categories):
    metadata = {}
    metadata['path'] = os.path.splitext(os.path.relpath(file, wiki_path))[0]

    with open(file, 'r') as f:
        text = f.read()

    # read headers and remove from text
    end = 0
    for match in re.finditer(r'\s*<!--\s*(.+?)\s*:\s*(.+?)\s*-->\s*|.+', text):
        if not match.group(1):
            break
        metadata[match.group(1)] = match.group(2)
        end = match.end()
    text = text[end:]

    # read title and remove from text
    match = re.match('# (.+?)\s*\n', text)
    if match is not None:
        metadata['title'] = match.group(1)
        text = text[match.end():]
    else:
        metadata['title'] = metadata['path']

    # read description
    match = re.match('\*([^* ].+?)\*\s*\n', text)
    if match is not None:
        metadata['description'] = match.group(1)

    if 'category' not in metadata:
        metadata['category'] = categories[-1]

    return metadata, text


def make_toc_file(path, wiki_path, categories):
    # generate categories' data
    cat_info = { c : [] for c in categories }
    for root, dirs, files in os.walk(wiki_path):
        for f in files:
            if f[-3:] == '.md' and os.path.join(wiki_path, root, f) != path:
                metadata = get_file_metadata_and_text(os.path.join(wiki_path, root, f), wiki_path, categories)[0]
                cat_info[metadata['category']].append(metadata)

    # generate markdown
    text = '<!-- category: {} -->\n# Table of Contents\n'.format(categories[0])
    for cat, files in cat_info.items():
        if len(files) != 0:
            text += '\n## ' + cat + '\n\n' if cat != categories[0] else '\n'
        for f in sorted(files, key=lambda x : x['title']):
            date = ' (' + f['date'] + ')' if 'date' in f else ''
            des = ': ' + f['description'] if 'description' in f else ''
            text += '- [' + f['title'] + '](' + f['path'] + ')' + date + des + '\n'

    # print to file
    with open(path, 'w') as f:
        f.write(text)


def href_to_html(match):
    href = match.group(2)
    if not re.search('://', match.group(2)):
        href += '.html'
        if match.group(3):
            href += '#' + match.group(3).replace(' ', '-').lower()
    return "[{}]({})".format(match.group(1), href)


def wiki_to_html(input_file, output_file, template_file, root_path, wiki_path, categories):
    params, text = get_file_metadata_and_text(input_file, wiki_path, categories)

    # format links for HTML
    text = re.sub('\[([^]]+)\]\(([^)#]*)(?:#([^)]*))?\)', href_to_html, text)

    params['metadata'] = ''
    if params['category'] != categories[0]:
        params['metadata'] += '<span class="category">' + params['category'] + '</span>'
    if 'date' in params:
        args = [int(i) for i in params['date'].split('-')]
        date_str = datetime.date(args[0], args[1], args[2]).strftime('%B %-d, %Y')
        params['metadata'] += '<span class="date">' + date_str + '</span>'
    if params['metadata'] != '':
        params['metadata'] = '<div class="metadata">' + params['metadata'] + '</div>'

    params['root_path'] = root_path
    params['content'] = markdown.markdown(text, extensions=['footnotes', 'fenced_code'], tab_length=2)

    with open(template_file, 'r') as f:
        html = f.read()

    # render template variables
    html = re.sub(r'{{\s*([^}\s]+)\s*}}', lambda m: str(params.get(m.group(1), m.group(0))), html)

    with open(output_file, 'w') as f:
        f.write(html)


# Arguments received:
#     0.  executable path
#     1.  force : [0/1] overwrite an existing file
#     2.  syntax : the syntax chosen for this wiki
#     3.  extension : the file extension for this wiki
#     4.  output_dir : the full path of the output directory
#     5.  input_file : the full path of the wiki page
#     6.  css_file : the full path of the css file for this wiki (ignored here)
#     7.  template_path : the full path to the wiki's templates
#     8.  template_default : the default template name
#     9.  template_ext : the extension of template files
#     10. root_path : a count of ../ for pages buried in subdirs. '-' if in root
#     11. toc_path : path from root to TOC (without extension)
#     12-.categories : the rest of the arguments are the categories in order.
#         The first category is used for meta files that should appear directly
#         in the root directory. The last category is used for files that have
#         not set any category.
if __name__ == '__main__':
    output_dir = sys.argv[4]
    input_file = sys.argv[5]
    output_file = os.path.join(output_dir, os.path.splitext(os.path.basename(input_file))[0]) + '.html'
    template_path = os.path.join(sys.argv[7], sys.argv[8]) + sys.argv[9]
    root_path = sys.argv[10] if sys.argv[10] != '-' else ''

    # if force is not enabled and HTML is already up to date, exit
    if sys.argv[1] == '0' and os.path.getmtime(output_file) > os.path.getmtime(input_file):
        sys.exit(0)

    if sys.argv[2] != 'markdown':
        print('Error: Unsupported syntax', file=sys.stderr)
        sys.exit(1)

    # global variables
    wiki_path = os.path.join(os.path.dirname(input_file), root_path)
    categories = [ c for c in sys.argv[12:] ]

    # make TOC if any files have been updated after TOC
    toc_path = os.path.join(wiki_path, sys.argv[11])
    for root, dirs, files in os.walk(wiki_path):
        if os.path.getmtime(toc_path) < os.path.getmtime(os.path.join(wiki_path, root)):
            make_toc_file(toc_path, wiki_path, categories)
            break
        for f in files:
            if os.path.getmtime(toc_path) < os.path.getmtime(os.path.join(wiki_path, root, f)):
                make_toc_file(toc_path, wiki_path, categories)
                break

    wiki_to_html(input_file, output_file, template_path, root_path, wiki_path, categories)
