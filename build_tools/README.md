These are very rough first-round scripts I've made to help me with a few of the rpmbuild tasks.

They should be placed in ~/rpmbuild/.

# autobuilder.sh
* operates on the names of packages in ./list.txt (foo, not foo-1.0)
* attempts to download and install the package's SRPM if not installed
* tries to version-match based on what's in the specfile if the specfile exists in the sgug-rse.git checkout
* if there's a SPEC and patches in sgug-rse.git checkout, copies them into rpmbuild
* rpmbuilds the package
* sudo installs the package
