#!/bin/bash

# run terraria server
# only work on linux

args=()
__main__(){
   cd $(dirname $(realpath "$0"))
   if [[ -d ${SERVER} ]] && -f ${STARTUP_SCRIPT} ]] 
   then
     if [[ -f ${CONFIG} ]]
     then
       __args -config "${CONFIG}"
     else
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

start_server(){
  
}

__init(){
  SERVER=ServerLinux
  STARTUP_SCRIPT="${SERVER}/TerrariaServer"
  CONFIG="config.conf"
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
__main__ "$@"

