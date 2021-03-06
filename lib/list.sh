list_to_map() {
	nl -v 0 -s ': value: ' -w 1
}

# $1 = function
list_filter() {
	local line
	while IFS= read -r line; do
		"$@" "$line" && echo "$line"
	done
}

# $1 = function
list_expand() {
	local line
	while IFS= read -r line; do
		"$@" "$line"
	done
}

# $1 = function
list_to_map_callback() {
	local list
	local line
	while IFS= read -r line; do
		list="$(map_set "$line" "$("$@" "$line")" <<<"$list")"
	done
	echo "$list"
}

list_next() {
	grep "$1$" -A 1 | grep -v "$1$"
}

list_prev() {
	grep "$1$" -B 1 | grep -v "$1$"
}
