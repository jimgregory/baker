trim() {
    local var
    read  -rd '' var
    echo "$var"
}

# convert string to hook
slug() {
    tr -cd '[:alnum:][:space:]' <<< "$*" | tr -s '[:space:]' - | tr '[:upper:]' '[:lower:]' | sed -e 's|-$||'
}

html_escape() {
	sed \
	-e 's|&|\&amp;|g' \
	-e 's|<|\&lt;|g' \
	-e 's|>|\&gt;|g' \
	-e 's|'\''|\&apos;|g' \
	-e 's|"|\&quot;|g'
}

split() {
	sed -e 's|, |\n|g' -e 's|,|\n|g'
}

newline_escape() {
	local line
	while IFS= read -r line; do
		echo -n "${line//\\/\\\\}\n"
	done
}

newline_unescape() {
	echo -e "$(cat)"
}

# TODO: fix utf-8
regex_offset() {
	local pat=()
	while [[ "$1" ]]; do
		pat+=(-e "$1")
		shift
	done
	grep -b -o "${pat[@]}"
}
