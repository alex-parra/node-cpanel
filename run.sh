#!/bin/sh

# On mac requires coreutils: `brew install coreutils`
SCRIPT_DIR=$(dirname $(realpath "$0"))
APP_NAME=node-cpanel
ENV_DEFAULTS=$SCRIPT_DIR/.env.defaults
ENV_LOCAL=$SCRIPT_DIR/.env

# ------------------------------------------------------------------------------
# Helper Functions

  # Usage: yesNo "A question?" && runIfYes
  yesNo() {
    read -p "> $1 (Y/n): " response
    case $response in
      Y) return 0 ;; # 0 is success/true code
      *) return 999 ;;
    esac
  }


  echoLine() {
    echo "-----------------------------------------------------------------------"
  }


  # Usage: echoColor red "Some error message to print in red"
  echoColor() {
    # Colors
    local ESC_SEQ="\x1b["
    local COL_RESET=$ESC_SEQ"39;49;00m"
    local COL_RED=$ESC_SEQ"31;01m"
    local COL_GREEN=$ESC_SEQ"32;01m"
    local COL_YELLOW=$ESC_SEQ"33;01m"
    local COL_BLUE=$ESC_SEQ"34;01m"

    case $1 in
      red) echo "$COL_RED$2$COL_RESET" ;;
      green) echo "$COL_GREEN$2$COL_RESET" ;;
      yellow) echo "$COL_YELLOW$2$COL_RESET" ;;
      blue) echo "$COL_BLUE$2$COL_RESET" ;;
      white) echo $2 ;;
    esac
  }


  abort() {
    echo;
    echoColor yellow "$1"
    echoColor red "Aborted"
    echo;
    exit;
  }

# ------------------------------------------------------------------------------
# Main

clear;

if test -f "$ENV_DEFAULTS"; then
  export $(cat $ENV_DEFAULTS | xargs)
fi

if test -f "$ENV_LOCAL"; then
  export $(cat $ENV_LOCAL | xargs)
fi

cd $SCRIPT_DIR

# Tasks (ex: `./run.sh test`)
case $1 in
  ssh)
    ssh -i ~/.ssh/vps-alexpds alexpds@vps1.hostingsoftag.com
    ;;

  d|dev)
    ./node_modules/.bin/nodemon ./src/server.js
    ;;

  prod)
    ./node_modules/.bin/pm2 delete pm2.config.js
    ./node_modules/.bin/pm2 start pm2.config.js
    ;;

  prod.stop)
    ./node_modules/.bin/pm2 stop pm2.config.js
    ;;

  pm2)
    ./node_modules/.bin/pm2 "${@:2}"
    ;;

  *)
    abort "Unknow task: ${1:-blank}"
    ;;
esac
