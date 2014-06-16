NAME=etcd
VERSION=0.4.3
RELEASE=1
TARBALL=$(NAME)-v$(VERSION)-linux-amd64.tar.gz
TARDIR=$(NAME)-v$(VERSION)-linux-amd64

all: $(NAME)-$(VERSION)-1.x86_64.rpm

SOURCES:
	ln -s . SOURCES 
SPECS:
	ln -s . SPECS 

SOURCES/$(TARBALL):
	./spectool --define "_sourcedir `pwd`" --define "_version $(VERSION)" -gf -C ./SOURCES/ $(NAME).spec 

$(NAME)-$(VERSION)-$(RELEASE).x86_64.rpm: SOURCES SPECS SOURCES/$(TARBALL)
	rpmbuild --define "_sourcedir `pwd`" --define "_version $(VERSION)" --define "_release $(RELEASE)" -bs ./SPECS/$(NAME).spec 
	mock -r epel-6-x86_64 rebuild --define "_version $(VERSION)" --define "_release $(RELEASE)" /home/`whoami`/rpmbuild/SRPMS/$(NAME)-$(VERSION)-1.src.rpm
	cp /var/lib/mock/epel-6-x86_64/result/$(NAME)-$(VERSION)-1.x86_64.rpm $@

