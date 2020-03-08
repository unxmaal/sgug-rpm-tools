#ifndef DEPENDENCYSET_HPP
#define DEPENDENCYSET_HPP

#include <rpm/rpmdb.h>
#include <rpm/rpmts.h>

namespace sgug_rpm {

  class rpmds_h {
  public:
    rpmds dependency_set;

    rpmds_h( Header installed_header, rpmTagVal tagN, int flags ) {
      dependency_set = rpmdsNew(installed_header, tagN, flags);
    }

    int next() { return rpmdsNext(dependency_set); };

    ~rpmds_h() {
      dependency_set = rpmdsFree(dependency_set);
    }
  };

}

#endif
