#include "helpers.hpp"

#include <iostream>

using std::cout;
using std::optional;
using std::string;
using std::pair;

static char indicators[] = {
  '|',
  '/',
  '-',
  '\\'
};

namespace sgug_rpm {

  optional<pair<string,string> > find_package_providing_file( const string & required ) {
    rpmts_h rpmts_helper;
    rpmtsiter_h iter_h( rpmts_helper, RPMDBI_INSTFILENAMES,
			required.c_str(), 0 );

    Header installed_package;

    bool found_installed_package = false;
    while( (installed_package = iter_h.next()) != NULL ) {
      found_installed_package = true;
      installed_package = headerLink(installed_package);

      const char *errstr;
      char * dep_name_c = headerFormat(installed_package, "%{NAME}", &errstr);
      string dep_name(dep_name_c);
      char * dep_rpmfile_c = headerFormat(installed_package, "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm", &errstr);
      string dep_rpmfile(dep_rpmfile_c);
      return { pair(dep_name, dep_rpmfile) };
    }
    

    return {};
  }

  optional<pair<string,string> > find_package_providing_tag( const string & required ) {
    rpmts_h rpmts_helper;
    rpmtsiter_h iter_h( rpmts_helper, RPMDBI_PROVIDENAME,
			required.c_str(), 0 );

    Header installed_package;

    bool found_installed_package = false;
    while( (installed_package = iter_h.next()) != NULL ) {
      found_installed_package = true;
      installed_package = headerLink(installed_package);

      const char *errstr;
      char * dep_name_c = headerFormat(installed_package, "%{NAME}", &errstr);
      string dep_name(dep_name_c);
      char * dep_rpmfile_c = headerFormat(installed_package, "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm", &errstr);
      string dep_rpmfile(dep_rpmfile_c);
      return { pair(dep_name, dep_rpmfile) };
    }
    

    return {};
  }

  progress_printer::progress_printer()
    : prev_value(0) {}

  void progress_printer::accept_progress() {
    cout << "\033[1D" << indicators[prev_value];
    cout.flush();
    prev_value = (prev_value + 1) % 4;
  }

  void progress_printer::reset() {
    prev_value = 0;
    cout << "\033[1D";
  }
}
