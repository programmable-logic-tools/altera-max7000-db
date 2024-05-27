#
# Create Python package
#

# One of the packages required for packaging controls
# installation of all build requirements (pars pro toto).
VENV_PACKAGING=$(DIR_VENV_SITE_PACKAGES)/build

# Package is rebuilt, when one of these dependencies change:
PKG_DEP += $(VENV_PACKAGING)
PKG_DEP += Makefile venv.mk package.mk
PKG_DEP += pyproject.toml
PKG_DEP += $(LIB_MAX7K_SRC)


# Install the packages required for packaging
.PHONY: venv_packaging
venv_packaging: $(VENV_PACKAGING)
$(VENV_PACKAGING): build/requirements.txt $(DIR_VENV)
	source $(DIR_VENV)/bin/activate && \
	  pip3 install -r $<
	@touch --no-create $@

# Entrypoint for packaging
.PHONY: package
package: dist

# Build package (wheel)
.SECONDARY: dist
dist: $(PKG_DEP)
	source "$(DIR_VENV)/bin/activate" && \
	  python3 -m build --wheel
	@touch --no-create "$@"

# Remove all packaging artifacts
.PHONY: clean_package
clean_package:
	@rm -vfr build/{bdist*,lib*} dist/ *.egg-info/
