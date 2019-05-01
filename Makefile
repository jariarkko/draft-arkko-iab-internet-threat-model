LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b master https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

cleantrash:
	rm -f *~

diff:	draft-arkko-arch-internet-threat-model.txt
	rfcdiff draft-arkko-arch-internet-threat-model-00.txt draft-arkko-arch-internet-threat-model.txt

copycompile:
	ssh jar@arkko.eu 'rm -rf draft-arkko-arch-internet-threat-model'
	ssh jar@arkko.eu 'mkdir draft-arkko-arch-internet-threat-model'
	scp -qrp * .git .circ* .trav* .gitignore jar@arkko.eu:draft-arkko-arch-internet-threat-model
	ssh jar@arkko.eu 'cd draft-arkko-arch-internet-threat-model; make; make diff'
	scp jar@arkko.eu:draft-arkko-arch-internet-threat-model/draft-arkko-arch-internet-threat-model.txt .
	scp jar@arkko.eu:draft-arkko-arch-internet-threat-model/*.html .
	scp draft-arkko-arch-internet-threat-model.txt \
		draft-arkko-arch-internet-threat-model.html \
		jar@cloud1.arkko.eu:/var/www/www.arkko.com/html/ietf/iab
