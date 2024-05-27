#
# Create documentation
#
DIR_DOC=$(DIR_MAX7K_DOC)

# Intermediate files will be generated in this directory
DIR_DOC_SRC=$(DIR_DOC)/source

# RST files will be generated in this directory
DIR_DOC_RST=$(DIR_DOC_SRC)/autodoc

# HTML output will be generated in this directory
DIR_DOC_HTML=$(DIR_DOC)/build

# Makefile dependencies for building RST files from the source code
DOC_RST_DEP=$(VENV_DOC) $(LIB_MAX7K_SRC)

# Makefile dependencies for building HTML from RST files
DOC_HTML_DEP=\
			$(VENV_DOC) \
			$(DIR_DOC_SRC)/conf.py \
			$(DIR_DOC_RST)/$(PACKAGE_NAME).rst \
			$(wildcard $(DIR_DOC_SRC)/*.rst) \
			$(wildcard $(DIR_DOC_RST)/*.rst)

# One of the packages required to build the documentation
# controls the installation of all documentation requirements (pars pro toto).
VENV_DOC=$(DIR_VENV_PKGS)/sphinx


# Install the packages required to build the documentation
$(VENV_DOC): $(DIR_DOC)/requirements.txt $(VENV_MAX7K_REQUIREMENTS)
	source $(DIR_VENV)/bin/activate \
	  && pip3 install -r $<
	@touch --no-create $@

# Initialize new documentation (only for new projects)
# Caveat: This Makefile target cannot depend on the virtual environment,
# otherwise conf.py would be overwritten whenever the environment changes.
.SECONDARY: $(DIR_DOC_SRC)/conf.py $(DIR_DOC_RST)/$(PACKAGE_NAME).rst
$(DIR_DOC_SRC)/conf.py:
	[ -e "$(VENV_DOC)" ] || make $(VENV_DOC)
	@mkdir -vp "$(shell dirname "$@")"
	source "$(DIR_VENV)/bin/activate" \
	  && cd $(DIR_DOC) \
	  && sphinx-quickstart
	@touch --no-create "$@"

# Entrypoint when building documentation
$(DIR_DOC): $(VENV_DOC) $(DIR_DOC)/build
	@touch --no-create "$@"

# Generate HTML from rST file
.PHONY: html
html: $(DIR_DOC)/build
$(DIR_DOC)/build: $(DOC_HTML_DEP)
	source "$(DIR_VENV)/bin/activate" \
	  && make -C "$(DIR_DOC)" html
	@touch --no-create "$@"

# Bundle the generation of any rST file under one common Makefile target
$(DIR_DOC_RST)/%.rst: $(DIR_DOC_RST)
	@touch --no-create "$@"

# Generate rST files from the source files
.PHONY: rst
rst: $(DIR_DOC_RST)
$(DIR_DOC_RST): $(DOC_RST_DEP)
	# Generating rST files from Python source code
	@mkdir -p "$(DIR_DOC_SRC)/templates" "$(DIR_DOC_SRC)/static" "$(DIR_DOC_RST)"
	@rm -vf "$(DIR_DOC_RST)/*.rst"
	source "$(DIR_VENV)/bin/activate" \
	  && sphinx-apidoc --force --separate --module-first -o "$(DIR_DOC_RST)" "$(DIR_SRC)"
	@touch --no-create "$@"

# Remove generated documentation artifacts
clean_doc:
	@rm -vfr "$(DIR_DOC)/build" "$(DIR_DOC_RST)/*.rst" "$(DIR_DOC)/make.bat"
	@rmdir -v --ignore-fail-on-non-empty \
		"$(DIR_DOC_RST)" \
		"$(DIR_DOC_SRC)/_templates" \
		"$(DIR_DOC_SRC)/templates" \
		"$(DIR_DOC_SRC)/_static" \
		"$(DIR_DOC_SRC)/static" \
		"$(DIR_DOC_SRC)" \
		"$(DIR_DOC)" || true

