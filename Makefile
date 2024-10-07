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

# List of all source files except Fun.cpp, FunN.cpp
SRCS := $(filter-out Fun.cpp FunN.cpp, $(wildcard *.cpp))
EXES := $(patsubst %.cpp,%.exe,$(SRCS))

# Rule to build all executables
all: $(EXES)

# Rule to create the shared library from Fun.cpp FunN.cpp
libFun.so: Fun.cpp
	$(CC) -c -fPIC Fun.cpp -o Fun.o
	$(CC) -shared -o libFun.so Fun.o
libFunN.so: FunN.cpp
	$(CC) -c -fPIC FunN.cpp -o FunN.o
	$(CC) -shared -o libFunN.so FunN.o

# Rule to compile other .cpp files directly into executables
$(EXES):%.exe:%.cpp $(SRCS) libFun.so libFunN.so
	$(CC) $< $(CC_FLAGS) $(LINK_OPTION) $(INCLUDES) -L. -lFun -lFunN -o E$@

clean:
	@echo "Cleaning up ......"
	@-rm -rf *.exe *.o *.i *.s *.a *.so # - prefix for ignoring errors
