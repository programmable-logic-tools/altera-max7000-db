#
# Virtual environment
#

# Detect Python version
PYTHON_VERSION=$(shell python3 -V | cut -d" " -f2 | cut -d"." -f1-2)

# Python packages will be installed to this directory
DIR_VENV_SITE_PACKAGES=$(DIR_VENV)/lib/python$(PYTHON_VERSION)/site-packages

# Executables expected to be present in the virtual environment
VENV_PYTHON=$(DIR_VENV)/bin/python3 $(DIR_VENV)/bin/pip3 $(DIR_VENV)/bin/activate


#
# Create virtual environment
#
$(DIR_VENV):
	@echo "Creating virtual environment in \"$@\"..."
	mkdir -p "$@"
	python3 -m venv "$@"
	@touch --no-create "$@"


$(DIR_VENV)/%: $(DIR_VENV)
	@touch --no-create --no-dereference "$@"


$(VENV_MAX7K_REQUIREMENTS): $(DIR_VENV)/bin/activate requirements.txt venv.mk
	source $(DIR_VENV)/bin/activate && \
	pip3 install -r requirements.txt
	@touch --no-create --no-dereference "$@"


.venv: $(DIR_VENV) $(VENV_PYTHON)
	@rm -fr --preserve-root "$@" && ln -vs "$<" "$@"


venv: .venv $(VENV_MAX7K) $(VENV_MAX7K_REQUIREMENTS)
	@rm -fr --preserve-root "$@" && ln -vs "$<" "$@"


#
# (Re)Install project requirements
#
.PHONY: venv_base
venv_base: $(VENV_BASE) $(VENV_MAX7K)
$(VENV_BASE): requirements.txt $(DIR_VENV)
	source $(DIR_VENV)/bin/activate \
	  && pip3 install -r $<
	@touch --no-create $@


#
# Remove virtual environment
#
.PHONY: clean_venv
clean_venv:
	@rm -fvr $(DIR_VENV) .venv
