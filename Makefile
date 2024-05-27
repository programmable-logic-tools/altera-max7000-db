
SHELL=bash

LIB_MAX7K:=$(if $(LIB_MAX7K),$(LIB_MAX7K),$(shell realpath .))
DIR_VENV_USER=$(shell realpath ~/.local/share/virtualenv/max7k)
DIR_VENV:=$(if $(DIR_VENV),$(DIR_VENV),$(DIR_VENV_USER))

include lib.mk

DIR_SRC=$(DIR_MAX7K_SRC)


all: kaitai test package doc


# Generate source code
include kaitai.mk

# Create virtual environment
include venv.mk

# Build documentation
include doc.mk

# Create Python package
include package.mk

# Run software tests
include test.mk


# Remove all generated and temporary Python files
.PHONY: clean_python clean_python_recursively
clean_python_recursively: clean_python
clean_python:
	@find "$(DIR_SRC)" -type f -name "*.pyc" -exec rm -vf {} \; 2>/dev/null || true
	@find "$(DIR_SRC)" -type d -name "__pycache__" -exec rm -vfr {} \; 2>/dev/null || true
	@find "$(DIR_SRC)" -type d -name ".pytest_cache" -exec rm -vfr {} \; 2>/dev/null || true
	@find "$(DIR_SRC)" -type d -name ".ipynb_checkpoints" -exec rm -vfr {} \; 2>/dev/null || true
	@rm -vfr .pytest_cache


# Remove all generated content
.PHONY: clean
clean:  clean_kaitai \
		clean_venv \
		clean_python \
		clean_package \
		clean_test \
		clean_doc
	@[[ -L data ]] && rm -vf --preserve-root data

