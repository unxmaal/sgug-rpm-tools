#ifndef INSTALLEDRPM_HPP
#define INSTALLEDRPM_HPP

#include "helpers.hpp"

#include <string>
#include <vector>
#include <unordered_map>

namespace sgug_rpm {
  class installedrpm {
  private:
    std::string _name;
    std::string _rpmfile;

    std::vector<std::string> _requires;
    std::vector<std::string> _provides;

  public:
    installedrpm() {};
    installedrpm( std::string name,
		  std::string rpmfile,
		  std::vector<std::string> requires,
		  std::vector<std::string> provides);
    const std::string & get_name() const { return _name; };
    const std::string & get_rpmfile() const { return _rpmfile; };
    const std::vector<std::string> & get_requires() const { return _requires; };
    const std::vector<std::string> & get_provides() const { return _provides; };
  };

  bool read_installedrpm( const std::string & packagename, installedrpm & dest );

  void read_installedrpms( const std::vector<std::string> & names,
			   std::vector<installedrpm> & out_instrpms,
			   std::vector<std::string> & error_instrpms );
}

#endif
