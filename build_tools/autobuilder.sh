#!/usr/sgug/bin/bash -e
set -o pipefail

_list=list.txt
_repodir=/usr/people/edodd/sgug-rse.git
_rpmlist=logs/rpmlist.txt
_buildlog=logs/build.log
_installed=logs/install.log
_fcurl="http://fedora.mirrors.pair.com/linux/releases/31/Everything/source/tree/Packages/"

getsrpm(){
  if [[ -e "${_repodir}/packages/$i/SPECS/$i.spec" ]] ; then
    local _version=$(grep 'Version:' "${_repodir}/packages/$i/SPECS/$i.spec" | awk '{print $2}')
    local _srpmname="${i}-${_version}"
  else
    local _srpmname="${i}-"
  fi

    if ! grep "$_srpmname" "$_rpmlist" ; then
      echo "not found"
      #get first letter
      local _fl=${i:0:1}
      #get the name of the rpm
      local _rn=$(curl "${_fcurl}${_fl}/" | grep "$_srpmname" | grep src.rpm | cut -d '=' -f4| cut -d\" -f2) 
      #get the url for the rpm
      local _rl="$_fcurl/$_fl/$_rn"
      #fetch the rpm
      curl -o "SRPMS/$_rn" "$_rl"
      #install the rpm
      sudo rpm -Uvh "SRPMS/$_rn"
    fi
}

newspecs(){
  if [[ -d "${_repodir}/packages/$i" ]] ; then
echo "t1"
    cp ${_repodir}/packages/$i/SPECS/* SPECS/.
echo "t2"
    if [[ -e "${_repodir}/packages/$i/SOURCES" ]] ; then
       cp ${_repodir}/packages/$i/SOURCES/* SOURCES/.
echo "t3"
    fi
  fi
}

mkdir -p logs
rpm -qa | sort > logs/rpmlist.txt

for i in $(cat $_list) ; do 
  getsrpm
  newspecs

  rpmbuild -ba --undefine=_disable_source_fetch -ba SPECS/$i.spec | tee "${_buildlog}"
  _buildval="${PIPESTATUS[0]}"
  if [[ $_buildval -ne 0 ]] ; then
	cp $_buildlog logs/$i.buildfailed
  fi

  _built=$(grep Wrote "${_buildlog}" | cut -d' ' -f2 | grep -v SRPM)
  for _b in $_built ; do
	sudo rpm -ivh --reinstall $_b
	_rv=$?
	if [[ $_rv -eq 0 ]] ; then
	  echo $_b >> "$_installed"
	else
	  echo $_b >> "logs/install_failed.log"
	fi
  done
done
