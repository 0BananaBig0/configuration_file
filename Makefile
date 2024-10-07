#################################################################
#											 Makefile
#		Makefile to build exe
#################################################################
.PHONY: clean, all

CC = g++
SHARED_LIB_PATH = -L/usr/lib/x86_64-linux-gnu \

# comment -ltclreadline, use rlwrap instead
SHARED_LIBS =  -ltcl \
							-lboost_program_options -lboost_date_time \
							-lboost_filesystem -lboost_system -lboost_iostreams \

LINK_OPTION = ${SHARED_LIB_PATH} ${SHARED_LIBS}
INCLUDES = -I/usr/include/tcl \

# DEBUG = -g
DEBUG =

CC_FLAGS = ${DEBUG} -fPIC -Wall -Wextra -std=c++17 \
					-Wno-error=deprecated-declarations

# list of object files
OBJS =

STATIC_LIB =

# list of OpenCL source files
OCL =

# list of header files
HEADERS =

# List of all source files except Fun.cpp
SRCS := $(filter-out Fun.cpp, $(wildcard *.cpp))
EXES := $(patsubst %.cpp,%,$(SRCS))

# Rule to build all executables
all: libFun.so $(EXES)

# Rule to create the shared library from Fun.cpp
libFun.so: Fun.cpp
	$(CC) -c -fPIC Fun.cpp -o Fun.o
	$(CC) -shared -o libFun.so Fun.o

# Rule to compile other .cpp files directly into executables
%: $(SRCS) libFun.so
	$(CC) $(CC_FLAGS) $(LINK_OPTION) $(INCLUDES) -L. -lFun -o $@.exe $<

clean:
	@echo "Cleaning up ......"
	@-rm -rf *.exe *.o *.i *.s *.a *.so # - prefix for ignoring errors
