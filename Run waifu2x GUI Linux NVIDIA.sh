#!/bin/bash
# requires libtiff5 or libtiff6

# Change to the directory where this script is located (handles sourcing and symlinks)
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
cd "$SCRIPT_DIR"

if [ ! -d ~/.venvs/nunif ]; then
    echo "Creating virtual environment 'nunif'..."
    python3 -m venv ~/.venvs/nunif
fi
source ~/.venvs/nunif/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
pip install -r requirements-gui.txt
pip install -r requirements-torch.txt
if [ ! -f /usr/lib/x86_64-linux-gnu/libtiff.so.6 ] && [ ! -f /usr/lib/x86_64-linux-gnu/libtiff.so.5 ]; then
    echo "Error: libtiff5 or libtiff6 is not installed."
    exit 1
fi
[ -f /usr/lib/x86_64-linux-gnu/libtiff.so.6 ] && [ ! -f /usr/lib/x86_64-linux-gnu/libtiff.so.5 ] &&
sudo ln -sf /usr/lib/x86_64-linux-gnu/libtiff.so.6 /usr/lib/x86_64-linux-gnu/libtiff.so.5
python -m waifu2x.gui