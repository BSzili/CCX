OSTYPE = $(shell uname -s)

#SHELL = /bin/sh
#CC  = /usr/bin/gcc-4.0
#CXX = g++-4.0
CC = gcc
CXX = g++
STRIP = strip

# Edit as needed
#FMOD_COMPILE_FLAGS = -I/usr/local/include/fmod/
#FMOD_LINK_FLAGS = -lfmod -framework Carbon

CFLAGS = -O3 $(shell sdl-config --cflags) -DUseSDLMixer
LDFLAGS = -lSDL_image
ifeq ($(OSTYPE), AROS)
LDFLAGS += -ljpeg -lpng -lz
endif
LDFLAGS += -lSDL_mixer 
ifeq ($(OSTYPE), AROS)
LDFLAGS += -lvorbisfile -lvorbis -logg -lmikmod
endif
LDFLAGS += $(shell sdl-config --libs)

GAME = CandyCrisis
OBJECTGAME = blitter.o \
	control.o \
	font.o \
	soundfx.o \
	music.o \
	gameticks.o \
	graphics.o \
	graymonitor.o \
	grays.o \
	gworld.o \
	hiscore.o \
	keyselect.o \
	level.o \
	main.o \
	moving.o \
	MTypes.o \
	next.o \
	opponent.o \
	pause.o \
	players.o \
	prefs.o \
	random.o \
	resources.o \
	score.o \
	SDLU.o \
	soundfx.o \
	tutorial.o \
	tweak.o \
	victory.o \
	zap.o

all: $(GAME)

.SUFFIXES: .o .cpp

%.o: %.cpp
	$(CXX) $(CFLAGS) $(FMOD_COMPILE_FLAGS) -c $< -o $@

$(GAME): $(OBJECTGAME)
	$(CXX) $^ -o $@ $(LDFLAGS) $(FMOD_LINK_FLAGS) -lstdc++
	$(STRIP) --strip-unneeded $@

clean:
	$(RM) -fv $(OBJECTGAME)

distclean: clean
	$(RM) $(GAME)
