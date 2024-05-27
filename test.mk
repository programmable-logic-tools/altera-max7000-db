#
# Run automated tests
#

# One of the packages required for testing
# controls the installation of all test requirements (pars pro toto).
VENV_TEST = $(DIR_VENV_SITE_PACKAGES)/pytest

# Makfile dependencies for the test target
TEST_DEP += $(VENV_TEST)
TEST_DEP += $(KAITAI_PY)
TEST_DEP += $(DIR_MAX7K_DATA)

# (Re-)Run tests whenever one of those files changes.
TEST_DEP_INOTIFY += Makefile venv.mk test.mk
TEST_DEP_INOTIFY += requirements.txt test/requirements.txt
TEST_DEP_INOTIFY += $(LIB_MAX7K_SRC)
TEST_DEP_INOTIFY += $(LIB_MAX7K_TESTFILES)

TEST_GITDIRRT = report.xml


# Install the packages required for testing
.PHONY: venv_test
venv_test: $(VENV_TEST)
$(VENV_TEST): test/requirements.txt venv
	source $(DIR_VENV)/bin/activate \
	  && pip3 install -r $<
	@if [ ! -e "$(VENV_MAX7K)" ]; then make "$(VENV_MAX7K)"; fi
	@touch --no-create $@


# Run pytest
# https://docs.gitlab.com/ee/ci/testing/unit_test_report_examples.html#python-example
.PHONY: test test_continuously
test: $(TEST_DEP)
	clear
	# Running component tests...
	source "$(DIR_VENV)/bin/activate" \
	  && pytest \
	  	-vv \
		-rs \
		--continue-on-collection-errors \
		--color=yes \
		--ignore=max7k/typing/ \
		--junitxml=$(TEST_GITDIRRT) \
		$(DIR_SRC) \
		$(DIR_TESTS) \


# Re-run pytest whenever a source file is modified
test_continuously:
	@while [ 1 ]; do \
	  make test; \
	  sleep 2; \
	  inotifywait -e modify $(TEST_DEP_INOTIFY) || exit 1; \
	  sleep 1; \
	done;


@PHONY: clean_test
clean_test:
	@rm -vf --preserve-root $(TEST_GITDIRRT) manifest.json data.xlsx data.ods
