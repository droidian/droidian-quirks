LIBRARY="libtls-padding.so:libgtk6216workaround.so"

case "${LD_PRELOAD}" in
	*${LIBRARY}*)
		# Already there
		return 0
		;;
	"")
		;;
	*)
		LIBRARY="${LIBRARY}:"
		;;
esac

if [ "${UID}" != "0" ]; then
	export LD_PRELOAD="${LIBRARY}${LD_PRELOAD}"
fi
