#################################################################
#											 Makefile
#		Makefile to build exe
#################################################################
.PHONY: clean

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

CC_FLAGS = ${DEBUG} -fPIC -Wall -std=c++17 \
					-Wno-error=deprecated-declarations

# list of object files
OBJS =

STATIC_LIB =

# list of OpenCL source files
OCL =

# list of header files
HEADERS =

# name of executable
SRCS := $(wildcard *.cpp )
EXES := $(patsubst %.cpp,%,$(SRCS))
 
all: $(EXES)
 
%: %.cpp
		$(CC) $(CC_FLAGS) $(LINK_OPTION) $(INCLUDES) -o E$@.exe $<

clean:
	@echo "Cleaning up ......"
	-rm -rf *.exe # - prefix for ignoring errors
