#
# This file is intended for inclusion in projects
# making use of this library via Makefiles
#
# Must be defined before inclusion:
# * LIB_MAX7K: The folder containing this file
# * DIR_VENV: The parent project's virtual environment folder
#
# Defines:
# * DIR_VENV_SITE_PACKAGES: The virtual environment's site-packages
# * VENV_MAX7K: Installation of this package into the virtual environment
#
PACKAGE_NAME  = max7k

# Relevant paths within the repositry
DIR_MAX7K_SRC       = $(LIB_MAX7K)
DIR_MAX7K_TEST      = $(LIB_MAX7K)
DIR_MAX7K_DOC       = $(LIB_MAX7K)/gh-pages

# Makefile dependency for repository update
LIB_MAX7K_GITDIR    = $(LIB_MAX7K)/.git

# Kaitai source files
LIB_MAX7K_KSY = $(shell find "$(DIR_MAX7K_SRC)" -maxdepth 8 -type f -name '*.ksy')

# Python source files
LIB_MAX7K_SRC       := $(shell find "$(DIR_MAX7K_SRC)" -maxdepth 8 -type f -name '*.py' -not -name '*_test.py') $(LIB_MAX7K_KSY)
LIB_MAX7K_TESTFILES := $(shell find "$(DIR_MAX7K_SRC)" "$(DIR_MAX7K_TEST)" -maxdepth 8 -type f -name '*_test.py')
LIB_MAX7K_TESTFILES += $(shell find "$(DIR_MAX7K_TEST)" -maxdepth 6 -type f -name '*.ipynb')

# Package generation output folder
LIB_MAX7K_PKG  =  $(LIB_MAX7K)/dist

# Detect Python version
PYTHON_VERSION=$(shell python3 -V | cut -d" " -f2 | cut -d"." -f1-2)

# Python packages will be installed to this directory
DIR_VENV_SITE_PACKAGES=$(DIR_VENV)/lib/python$(PYTHON_VERSION)/site-packages

# Package installation path
VENV_MAX7K = $(DIR_VENV_SITE_PACKAGES)/$(PACKAGE_NAME)

# Pars pro toto-requirement for this package
VENV_MAX7K_REQUIREMENTS=$(DIR_VENV_SITE_PACKAGES)/kaitaistruct.py


# Makefile dependency cloning possible git submodules
$(LIB_MAX7K): $(LIB_MAX7K_GITDIR)
	@touch --no-create $@


# Update possible git submodules
$(LIB_MAX7K_GITDIR):
	# Updating git submodules in: $(LIB_MAX7K)
	git submodule update --init --recursive $(dir $@)
	@touch --no-create $@


data $(DIR_MAX7K_DATA):
	@if [ ! -e "$@/.git" ]; then \
		[[ -L "$@" ]] && rm -vf --preserve-root "$@"; \
		[[ -d "$@" ]] && rmdir -v "$@"; \
		if [ -d "../../data/max7k" ]; then \
			ln -vs "../../data/max7k" "$@"; \
		else \
			mkdir -p "$@"; \
			git submodule update --init "$@"; \
		fi; \
	fi
	@touch --no-create --no-dereference "$@"


# Install the package into the virtual environment
# Note: This target does not re-package, if the project is installed as editable i.e. symlinked.
.PHONY: venv_max7k
venv_max7k: $(VENV_MAX7K)
$(VENV_MAX7K): $(LIB_MAX7K) $(DIR_VENV) $(DIR_VENV_SITE_PACKAGES)
	@if [ ! -L "$@" ]; then \
		echo "Installing into the virtual environment: $<"; \
		source $(DIR_VENV)/bin/activate && \
		pip3 install --editable $< && \
		cd $(DIR_VENV_SITE_PACKAGES) && \
		ln -s $(DIR_MAX7K_SRC) $(notdir $@); \
	fi
	@touch --no-create $@


# Package this project and update the package whenever a source file is modified
$(LIB_MAX7K_PKG): $(LIB_MAX7K_GITDIR) $(LIB_MAX7K_SRC)
	# Creating package in: $(LIB_MAX7K)
	make -C $(LIB_MAX7K) package
	@touch --no-create $@


# Force rebuild of the package
.PHONY: rebuild_max7k
rebuild_max7k: clean_max7k $(LIB_MAX7K_PKG)


# Remove the package
.PHONY: clean_max7k
clean_max7k:
	@rm -vfr $(LIB_MAX7K_PKG)
	@[[ -L "$(DIR_MAX7K_DATA)" ]] && rm -vf --preserve-root "$(DIR_MAX7K_DATA)"

