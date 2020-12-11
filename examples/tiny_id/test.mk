.PHONY : test
test: do_all
	@id1=`${.OBJDIR}/tiny_id`; \
	id2=`id | awk '{print $$1, $$2}'`; \
	test _"$$id1" = _"$$id2"; ex=$$?; \
	true _______ cleandir _______; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	exit $$ex
