#!/bin/bash
# run mobile terraria server

__init__(){
  #WD="${PWD}"
  #PROGRAM_DIR="$(dirname "$(realpath "0")")"
  #cd "${PROGRAM_DIR}" || PROGRAM_DIR="${WD}"
  server="server"
  config_file="server.properties"
  __load_config__ "${config_file}"
}

__load_config__(){
}

__main__(){
  __init__
  if [[ -d ${server} ]] &&
  then
    mkdir -p worlds
    __args -world "${PWD}/world.wld" -autocreate -worldname world -motd "A Mobile Terraria Server" -port 7777
  fi
}

__args_add(){
  if [[ -z ${count:-} ]]
  then
    count=0
  fi
  while(($#>0))
  do
    args[${count}]="$1"
    let count++
    shift
  done
}

__args_clean(){
  unset args
}

start_server(){
  
}

__fix_script_permission(){
  local f
  for f in "${STARTUP_SCRIPT}"*
  do
    if [[ ! -x ${f} ]]
    then
      chmod +x "${f}"
    fi
  done
}
__exec_startup(){
  echo "+ env -i \"${STARTUP_SCRIPT}\" ${args[*]}"
  exec env -i "${STARTUP_SCRIPT}" "${args[@]}"
}
__exec_server(){
  local basename="TerrariaServer.bin"
  local arch="$(uname -m)"
  local bin="${server}/${basename}.${arch}"
  if [[ ! -f ${bin} ]]
  then
    echo "${bin} not found!"
    exit 127
  fi
  if [[ ! -x ${bin} ]]
  then
    chmod +x "${bin}"
  fi
  "${bin}" "$@"
}
__safe_exec(){
  set -e
  echo "+ $*"
  "$@"
  set +e
}

# 传递参数给主方法
__main__ "$@"
