#!/usr/sgug/bin/bash
_specdir=SPECS
_rpmlist=logs/rpmlist.txt
_niw=logs/not_in_wip.txt
_iw=logs/in_wip.txt
_atw=logs/add_to_wip.txt
_mdir=migration

for f in "$_niw" "$_iw" "$_atw" ; do
    if [[ -e "$f" ]] ; then
		rm "$f"
	fi
done

sudo rpm -qa | sort > "$_rpmlist"

for s in ${_specdir}/*.spec ; do
	_fn=$(basename $s)
	if ! find /usr/people/edodd/projects/github/sgug-rse-wip/packages/. -name "$_fn" |read ; then
  	    if ! find /usr/people/edodd/sgug-rse.git/packages/. -name "$_fn" |read ; then
  		  echo "$_fn" >> "$_niw"
  		  _bn=$(basename "$_fn" .spec)
  		  grep -i ^"$_bn" "$_rpmlist"
  		  _iv=$?
  		  if [[ $_iv -eq 0 ]] ; then
  			  echo "$_fn" >> "$_atw"
			  mkdir -p "$_mdir/$_bn/SPECS"
			  cp ${s}* "$_mdir/$_bn/SPECS/."
			  if find "SOURCES/$_bn.irixfixes*.patch" | read; then
				  mkdir -p "$_mdir/$_bn/SOURCES"
			      cp SOURCES/$_bn.irixfixes*.patch "$_mdir/$_bn/SOURCES/."
			  fi
  		  fi
  	    else
  		  echo "$_fn" >> "$_iw"
  	    fi
	fi
done

exit 0
