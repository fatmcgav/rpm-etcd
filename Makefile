V=0.3.0

all: etcd-$(V)-1.x86_64.rpm

SOURCES:
	ln -s . SOURCES 
SPECS:
	ln -s . SPECS 

SOURCES/etcd-v0.3.0-linux-amd64.tar.gz: 
	spectool --define "_sourcedir `pwd`"  -gf -C ./SOURCES/ etcd.spec 

etcd-$(V)-1.x86_64.rpm: SOURCES SPECS SOURCES/etcd-v0.3.0-linux-amd64.tar.gz
	rpmbuild --define "_sourcedir `pwd`"  -bs ./SPECS/etcd.spec 
	mock -r epel-6-x86_64 rebuild  /home/sbopr/rpmbuild/SRPMS/etcd-$(V)-1.src.rpm
	cp  /var/lib/mock/epel-6-x86_64/result/etcd-$(V)-1.x86_64.rpm $@

