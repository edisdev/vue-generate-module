
#!/bin/bash

function readJson {  
  UNAMESTR=`uname`
  if [[ "$UNAMESTR" == 'Linux' ]]; then
    SED_EXTENDED='-r'
  elif [[ "$UNAMESTR" == 'Darwin' ]]; then
    SED_EXTENDED='-E'
  fi; 

  VALUE=`grep -m 1 "\"${2}\"" ${1} | sed ${SED_EXTENDED} 's/^ *//;s/.*: *"//;s/",?//'`

  if [ ! "$VALUE" ]; then
    echo "Error: Cannot find \"${2}\" in ${1}" >&2;
    exit 1;
  else
    echo $VALUE ;
  fi; 
}



function getOption {
  key=$1
  echo `readJson create-module-config.json $key` || exit 1;  
}


function createModule {
  path=$1
  name=$2
  file=$3
  if [[ ! -e $path/$name ]]; then
     cd -P -- "$path" && mkdir -p "$name" && cd "$name" && touch "$file"
  else 
      echo "$path/$name already exists but is not a directory" 1>&2
  fi
}


pagePath=$(getOption 'pagePath')
componentPath=$(getOption 'componentPath')
storePath=$(getOption 'storePath')
ignoreStore=$(getOption 'ignoreStore')
name=$1


if [ -z "$name" ]
then
  echo "PLEASE TYPING MODULE NAME"
  exit -1
fi


read -p "What do you want to create ? Pages (P/p) Or Components (C/c) ?" template

lowercaseTemplate=$(echo ${template} | tr '[:upper:]' '[:lower:]')

case $lowercaseTemplate in
  p)
     echo "Creating pages ... Please waiting ..."

    `createModule $pagePath $name "index.vue"`
     
     echo "66: $ignoreStore"
     if [ $ignoreStore == "false" ]
     then
     `createModule $storePath $name "index.js"`
     fi
      ;;
  c)
      echo "Creating component ... Please waiting ..."
      `createModule $componentPath $name "index.vue"`
      ;;
  *)
      echo "Uncorrent module!"
      ;;
esac