#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 input.txt output.csv"
  exit 1
fi

IN="$1"
OUT="$2"

python3 - "$IN" "$OUT" <<'PY'
import re
import csv
import sys
from pathlib import Path

in_path = Path(sys.argv[1])
out_path = Path(sys.argv[2])

text = in_path.read_text(encoding="utf-8", errors="replace")

# Extract project name if present
m = re.search(r"^Project name\s*:\s*(.+)$", text, flags=re.MULTILINE)
project = m.group(1).strip() if m else ""

start_marker = "-------------------- Questions / Answer --------------------"
end_marker = "-------------------- Non answered Questions --------------------"

start = text.find(start_marker)
if start == -1:
    raise SystemExit("ERROR: 'Questions / Answer' section not found.")

end = text.find(end_marker, start)
section = text[start + len(start_marker): (end if end != -1 else len(text))]

lines = [ln.rstrip() for ln in section.splitlines()]

qa = []
state = "seek_q"
q = None
a_lines = []
q_index = 0

def flush(q, a_lines, q_index, qa):
    """Return updated (q_index, qa) after flushing current pair if valid."""
    if q is None:
        return q_index, qa
    answer = "\n".join(a_lines).strip()
    if answer:
        q_index += 1
        qa.append((q_index, q.strip(), answer))
    return q_index, qa

for ln in lines:
    # Skip pure separator lines
    if re.match(r"^-{5,}\s*$", ln):
        continue

    if not ln.strip():
        # Blank line ends an answer block
        if state == "in_a":
            q_index, qa = flush(q, a_lines, q_index, qa)
            q = None
            a_lines = []
            state = "seek_q"
        continue

    if state == "seek_q":
        q = ln.strip()
        a_lines = []
        state = "in_a"
    else:
        a_lines.append(ln)

# Flush last pair if needed
if state == "in_a":
    q_index, qa = flush(q, a_lines, q_index, qa)

if not qa:
    raise SystemExit("ERROR: No Q/A pairs parsed. Check the input formatting.")

with out_path.open("w", encoding="utf-8", newline="") as f:
    w = csv.writer(f, delimiter=",", quotechar='"', quoting=csv.QUOTE_ALL)
    w.writerow(["project", "q_index", "question", "answer"])
    for idx, question, answer in qa:
        w.writerow([project, idx, question, answer])

print(f"OK: wrote {len(qa)} Q/A pairs to {out_path}")
PY