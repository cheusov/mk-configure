#include <stdio.h>
#include <unistd.h>
#include <assert.h>

#include <mkc_pwdgrp.h>

int main(int argc, char **argv)
{
	uid_t uid = getuid();
	gid_t gid = getgid();

	const char *username = user_from_uid(uid, 0);
	const char *group = group_from_gid(gid, 0);

	printf("uid=%u(%s) gid=%u(%s)\n", (unsigned)uid, username, (unsigned)gid, group);

	assert(!uid_from_user(username, &uid));
	assert(!gid_from_group(group, &gid));

	return 0;
}
