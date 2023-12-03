function godot {
    <ABSOLUTE_PATH_TO_GODOT> "$@"
}

function butler {
    <ABSOLUTE_PATH_TO_ITCHIO_BUTLER> "$@"
}

function gut {
    godot --script res://addons/gut/gut_cmdln.gd "$@"
}
