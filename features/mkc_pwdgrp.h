/*
 * Copyright © 2015-2017 Aleksey Cheusov <vle@gmx.net>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _MKC_PWDGRP_H_
#define _MKC_PWDGRP_H_

#ifndef _MKC_CHECK_PWDGRP
# error "Missing MKC_FEATURES += pwdgrp"
#endif

#include <pwd.h>
#include <grp.h>

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#ifndef HAVE_FUNC2_USER_FROM_UID_PWD_H
const char *user_from_uid(uid_t uid, int nouser);
#endif

#ifndef HAVE_FUNC2_GROUP_FROM_GID_GRP_H
const char *group_from_gid(gid_t gid, int nogroup);
#endif

#ifndef HAVE_FUNC2_UID_FROM_USER_PWD_H
int uid_from_user(const char *name, uid_t *uid);
#endif

#ifndef HAVE_FUNC2_GID_FROM_GROUP_GRP_H
int gid_from_group(const char *name, gid_t *gid);
#endif

__MKC_END_DECLS

#endif /* _MKC_PWDGRP_H_ */
