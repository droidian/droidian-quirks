#!/bin/bash
#
# Regenerates the ssh host keys
#

set -e

STAMP="/etc/ssh/droidian-keys-regenerated"

### The following three functions come from the Debian openssh-server
### package's postinst
### Copyright: Matthew Vernon, Colin Watson
### License: BSD-2-clause
host_keys_required() {
	# No HostKey directives at all, so the server picks some
	# defaults.
	echo /etc/ssh/ssh_host_rsa_key
	echo /etc/ssh/ssh_host_ecdsa_key
	echo /etc/ssh/ssh_host_ed25519_key
}

create_key() {
	msg="$1"
	shift
	hostkeys="$1"
	shift
	file="$1"
	shift

	if echo "$hostkeys" | grep -x "$file" >/dev/null && \
	   [ ! -f "$file" ] ; then
		printf %s "$msg"
		ssh-keygen -q -f "$file" -N '' "$@"
		echo
		if command -v restorecon >/dev/null 2>&1; then
			restorecon "$file" "$file.pub"
		fi
		ssh-keygen -l -f "$file.pub"
	fi
}


create_keys() {
	hostkeys="$(host_keys_required)"

	create_key "Creating SSH2 RSA key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_rsa_key -t rsa
	create_key "Creating SSH2 DSA key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_dsa_key -t dsa
	create_key "Creating SSH2 ECDSA key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_ecdsa_key -t ecdsa
	create_key "Creating SSH2 ED25519 key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_ed25519_key -t ed25519
}
### End functions coming from the openssh-server package


if [ -e "${STAMP}" ]; then
	echo "Keys already regenerated"
	exit 0
fi

rm -f \
	/etc/ssh/ssh_host_rsa_key \
	/etc/ssh/ssh_host_dsa_key \
	/etc/ssh/ssh_host_ecdsa_key \
	/etc/ssh/ssh_host_ed25519_key

create_keys

touch "${STAMP}"

exit 0
