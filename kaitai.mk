
# Kaitai compiler
KSC=kaitai-struct-compiler

KAITAI_SRC=$(shell find . -maxdepth 3 -type f -name '*.ksy')

# Kaitai targets
KAITAI_RUST=$(KAITAI_SRC:.ksy=.rs)
KAITAI_CPP=$(KAITAI_SRC:.ksy=.cpp)
KAITAI_PY=$(KAITAI_SRC:.ksy=.py)
KAITAI_DOT=$(KAITAI_SRC:.ksy=.dot)
KAITAI_PNG=$(KAITAI_SRC:.ksy=.png)

# Re-run component tests, whenever the Kaitai source changes
TEST_DEP_INOTIFY += kaitai.mk
TEST_DEP_INOTIFY += $(KAITAI_SRC)
TEST_DEP_INOTIFY += $(KAITAI_PY)


.PHONY: kaitai
kaitai: $(KAITAI_PNG) $(KAITAI_PY)


%.rs: %.ksy
	$(KSC) -t rust --outdir=$(dir $@) $<


%.cpp: %.ksy
	$(KSC) -t cpp_stl --outdir=$(dir $@) $<


%.py: %.ksy
	$(KSC) -t python --outdir=$(dir $@) $<


.SECONDARY: $(KAITAI_DOT)
$(KAITAI_DOT): %.dot: %.ksy
	$(KSC) -t graphviz --outdir=$(dir $@) $<


$(KAITAI_PNG): %.png: %.dot
	dot -Tpng $< > $@


.PHONY: clean_kaitai
clean_kaitai:
	@rm -vf $(KAITAI_CPP) $(KAITAI_PY) $(KAITAI_DOT) $(KAITAI_PNG) $(KAITAI_RUST)

