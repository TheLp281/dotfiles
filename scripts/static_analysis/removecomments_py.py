"""Remove comment lines from python scripts"""
import sys
import tokenize
from io import StringIO

if len(sys.argv) != 2:
    print("Please provide a Python file to process.")
    sys.exit(1)

filename = sys.argv[1]

with open(filename, 'r', encoding='utf-8') as f:
    source = f.read()

output = []

tokens = tokenize.generate_tokens(StringIO(source).readline)

for tok_type, tok_string, _, _, _ in tokens:
    if tok_type != tokenize.COMMENT:
        output.append(tok_string if tok_type != tokenize.NL else '\n')

with open(filename, 'w', encoding='utf-8') as f:
    f.write(''.join(output))
