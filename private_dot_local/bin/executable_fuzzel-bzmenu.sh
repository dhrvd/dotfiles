#!/bin/bash

LAUNCHER_COMMAND="fuzzel --dmenu \
   --hide-prompt \
   --minimal-lines \
   --width 24"

bzmenu --launcher custom \
  --launcher-command "$LAUNCHER_COMMAND" \
  --spaces 2

