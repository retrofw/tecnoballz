PRGNAME     = potator

# define regarding OS, which compiler to use
EXESUFFIX = 
TOOLCHAIN = 
CC          = /opt/rs97-toolchain/bin/mipsel-linux-gcc
CXX			= /opt/rs97-toolchain/bin/mipsel-linux-g++

# change compilation / linking flag options
F_OPTS		= -DTECNOBALLZ_HANDHELD_CONSOLE -Isrc -I.
CC_OPTS		= -Ofast -fomit-frame-pointer -fdata-sections -ffunction-sections $(F_OPTS)
CFLAGS		= -I$(SDL_INCLUDE) $(CC_OPTS)
CXXFLAGS	=$(CFLAGS) 
LDFLAGS     =  -lSDL_mixer -lmad -lmikmod -lmodplug -lvorbisidec -logg -lSDL -lSDL_image -ltinyxml -lm -lpng -ljpeg -lz -lstdc++ -Wl,--as-needed -Wl,--gc-sections -flto

# Files to be compiled
SRCDIR    = ./src
VPATH     = $(SRCDIR)
SRC_C   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_CP   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.cc))
OBJ_C   = $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_CP   = $(notdir $(patsubst %.cc, %.o, $(SRC_CP)))
OBJS     = $(OBJ_C) $(OBJ_CP)

# Rules to make executable
$(PRGNAME)$(EXESUFFIX): $(OBJS)  
	$(CC) $(CFLAGS) -o $(PRGNAME)$(EXESUFFIX) $^ $(LDFLAGS)

$(OBJ_C) : %.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_CP) : %.o : %.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(PRGNAME)$(EXESUFFIX) *.o
