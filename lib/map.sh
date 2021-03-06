append() {
	cat
	while [[ "$1" ]]; do
		echo "$1"
		shift
	done
}

# $1 = key
# $2 = value
map_set() {
	if [[ ! "$1" ]]; then
		sed '/^$/d'
		return
	fi
    map_delete "$1" | append "$1: $(trim <<<"$2" | newline_escape)" | map_set "${@:3}"
}

# $1 = key
map_get() {
	grep "^$1: " | cut -d ' ' -f 2- | newline_unescape
}

# $1 = key
map_delete() {
	grep -v "^$1: "
}

map_keys() {
	local line
	while IFS= read -r line; do
		[[ "$line" =~ ^([^\ ]+):\  ]] && echo "${BASH_REMATCH[1]}"
	done
}

map_len() {
	wc -l
}

is_map() {
	local line
	while IFS= read -r line; do
		[[ "$line" =~ ^[^\ ]+:\  ]] || return 1
	done
	return 0
}

map_merge() {
	while [[ "$1" ]]; do
		echo "$1"
		shift
	done | sort -k 1,1 -u
}

map_numindex() {
	cut -d ' ' -f 2- | nl -v 0 -s ': ' -w 1
}
