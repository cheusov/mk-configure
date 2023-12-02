NROFF_MAN2CAT.OSF1  =	-man
LD_TYPE.OSF1        =	osf1ld
LDFLAGS.shared.osf1ld =	-shared -msym -expect_unresolved '*'
LDFLAGS.soname.osf1ld =	-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR} \
				-set_version ${SHLIB_MAJOR}.${SHLIB_MINOR} \
				-update_registry ${.OBJDIR}/${LIB}_so_locations
.if ${TARGET_OPSYS:Unone} == "OSF1" && defined(LIB)
CLEANFILES +=			${.OBJDIR}/${LIB}_so_locations
.endif
