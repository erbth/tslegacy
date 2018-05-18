# Utility functions tha are commonly used in bash scripts

# Debuging facilities
export DEBUG_LEVEL_DEBUG=3
export DEBUG_LEVEL_INFO=2
export DEBUG_LEVEL_NORMAL=1

export DEBUG_LEVEL=$DEBUG_LEVEL_NORMAL

function debug
{
    if [ "$DEBUG_LEVEL" -ge $DEBUG_LEVEL_DEBUG ]
    then
        echo "DEBUG: $1" >&2
    fi
}

function info
{
    if [ "$DEBUG_LEVEL" -ge $DEBUG_LEVEL_INFO ]
    then
        echo "INFO: $1" >&2
    fi
}

function error
{
    echo "ERROR: $1" >&2
}

function output
{
    echo "$1"
}

# Arguments: commandline ("$@")
function enable_debug_from_cmdline
{
    for OPT in "$@"
    do
        case "$OPT" in
        "--debug" | "-vv")
            DEBUG_LEVEL=$DEBUG_LEVEL_DEBUG
            return
            ;;

        "-v")
            DEBUG_LEVEL=$DEBUG_LEVEL_INFO
            ;;

        *)
            ;;
        esac
    done
}
