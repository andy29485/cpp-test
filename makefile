.PHONY: all, clean, cleanall

# define global variables (compiler / flags)
CXX      := g++
CPPFLAGS += -DBOOST_LOG_DYN_LINK
LDFLAGS  += -lpthread
LDFLAGS  += -lxmlwrapp

# uncomment to compile in debug mode
# DEBUG = -g

# define
SRCDIR = src
OBJDIR = objs
INCDIR = include
BINDIR = bin

# project directories inside `src/` that should get compiled into something
TARGETS := \
	logger         \
	xml-validator  \

# boost libraries used (for linker)
BOOST_MODULES := \
	log 		\
	thread  \
  system  \

# ---------------------------------------------------------
# Note: don't edit below this point unless there's an error
# ---------------------------------------------------------

SOURCE_FILES := $(wildcard $(TARGETS:%=$(SRCDIR)/%/*.cpp))

# convert modules -> lib flags for linker
BOOST_LDFLAGS := $(addprefix -lboost_,$(BOOST_MODULES))

# define paths to target executes, object files
TARGETS  := $(addprefix $(BINDIR)/,$(TARGETS))
OBJECTS  := $(SOURCE_FILES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

# define include dir flags, compile flags, and linker flags
INCLUDE  := $(addprefix -I,$(INCDIR))
CPPFLAGS += $(BOOST_CPPFLAGS) $(INCLUDE) $(DEBUG)
LDFLAGS  += $(BOOST_LDFLAGS)

# define object dir patter for each executable
# (eval at runtime -- `=` not `:=`)
PDIR = $(patsubst $(BINDIR)%, $(OBJDIR)%, $@)

all: $(TARGETS)

# compile binary files -- only link objects in corresponding src/obj dir
$(TARGETS): $(OBJECTS) $(BINDIR) makefile
	$(CXX) $(LDFLAGS) $(CPPFLAGS) -o $@ $(filter $(PDIR)%, $(OBJECTS))

# general compile rule
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp $(OBJDIR) makefile
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -c $< -o $@

# make obj dir if not exist
$(OBJDIR):
	mkdir $(OBJDIR)

# make bin dir if not exist
$(BINDIR):
	mkdir $(BINDIR)

# delete only object files
clean:
	rm -f $(OBJDIR)/*.o $(OBJDIR)/*/*.o

# delete binaries and objects
cleanall: clean
	rm -rf $(BINDIR) $(OBJDIR)
