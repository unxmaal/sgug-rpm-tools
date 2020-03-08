NULL=

bin_PROGRAMS=sgug_world_builder \
	sgug_minimal_computer

sgug_world_builder_SOURCES=				\
	dependencyset.hpp				\
	helpers.hpp					\
	installedrpm.hpp				\
	sgug_dep_engine.hpp				\
	specfile.hpp					\
	sgug_world_builder.cpp				\
	specfile.cpp					\
	installedrpm.cpp				\
	helpers.cpp					\
	$(NULL)

sgug_minimal_computer_SOURCES=				\
	dependencyset.hpp				\
	helpers.hpp					\
	installedrpm.hpp				\
	sgug_dep_engine.hpp				\
	specfile.hpp					\
	sgug_minimal_computer.cpp			\
	specfile.cpp					\
	installedrpm.cpp				\
	helpers.cpp					\
	sgug_dep_engine.cpp				\
	$(NULL)

AM_CFLAGS=						\
	$(SGUG_RPM_TOYS_DEPS_CFLAGS)			\
	$(NULL)

sgug_world_builder_LDADD=				\
	$(SGUG_RPM_TOYS_DEPS_LIBS)			\
	-lrpmbuild					\
	$(NULL)

sgug_minimal_computer_LDADD=				\
	$(SGUG_RPM_TOYS_DEPS_LIBS)			\
	-lrpmbuild					\
	$(NULL)

CLEANFILES=						\
	.libs						\
	$(NULL)
