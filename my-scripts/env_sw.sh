#! /bin/bash
#
# Zeng Ganghui 2018/5/15
#

envname="$1"

function usage {
  echo "Usage: $0 envname"
  echo "  envname : td-test, td-dev"
  exit 0
}

[ "$envname" == "" ] && usage

env_dir="`pwd`/../inventory/td-test"
if [ ! -d $env_dir ] ; then
  echo "no env dir $env_dir"
  exit 1
fi
cd $env_dir


function switch_dir {
  src_conf=$1
  dst_conf=$2

  if [ ! -d $src_conf ] ; then
    echo "directory $src_conf does not exist"
    return 1
  fi

  if ! rm -f $dst_conf ; then
    echo "rm symbole $dst_conf failed"
    return 1
  fi

  if ln -s $src_conf $dst_conf ; then
    echo -n "."
    return 0
  else
    echo "switch $dst_conf failed."
    return 1
  fi
}

###### switch inventory ######
if ! switch_dir "$env_dir" "/etc/ansible" ; then
  usage
fi

echo -e "\nswitch to env $envname success"

