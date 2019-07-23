#! /bin/bash

THIS_SCRIPT="$( realpath "$0" )"
THIS_PATH="$( dirname "$THIS_SCRIPT" )"
: ${BOOTSTRAP_PY_BRANCH:=master}
: ${BOOTSTRAP_PY:=https://raw.githubusercontent.com/lalmeras/clickable_bootstrap/${BOOTSTRAP_PY_BRANCH}/bootstrap.py}

BOOTSTRAP_COMMAND="poetry config settings.virtualenvs.create false && cd '$THIS_PATH' && poetry install -v"

curl -s -o - "${BOOTSTRAP_PY}" | BOOTSTRAP_COMMAND="$BOOTSTRAP_COMMAND" BOOTSTRAP_PATH="$THIS_PATH" python - "$@"
