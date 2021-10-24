#
# Meant to be sourced
#
#Text color variables
#
fgBlack=$(tput setaf 0) 	# black
fgRed=$(tput setaf 1) 		# red
fgGreen=$(tput setaf 2) 	# green
fgYellow=$(tput setaf 3) 	# yellow
fgBlue=$(tput setaf 4) 		# blue
fgMagenta=$(tput setaf 5) 	# magenta
fgCyan=$(tput setaf 6) 		# cyan
fgWhite=$(tput setaf 7) 	# white
#
txBold=$(tput bold)   		# bold
txHalf=$(tput dim)    		# half-bright
txUnderline=$(tput smul)   	# underline
txEndUnder=$(tput rmul)   	# exit underline
txReverse=$(tput rev)    	# reverse
txStandout=$(tput smso)   	# standout
txEndStand=$(tput rmso)   	# exit standout
txReset=$(tput sgr0)   	    # reset attributes

function printError() {
    errorMsg=$*
    printf "${fgRed}$*${txReset}\n"
}

function setProjectsBase() {
    #
    # Define your own variable if you do not like mine
    if [[ -z "${PROJECTS_BASE}" ]]; then
        export PROJECTS_BASE="/Users/humberto.a.sanchez.ii/PycharmProjects"
    fi
    printf "Projects base directory: ${txReverse}${PROJECTS_BASE}${txReset}\n"
}
function doParamsExist() {

    # Exits script with appropriate error code if parameters do not exist
    #
    PROJECT_DIR=${1}
    APPLICATION_NAME=${2}

    if [ -z $PROJECT_DIR ]; then
            printError "Provide the directory name of the project"
            exit 66
    fi
    if [ -z $APPLICATION_NAME ]; then
            printError "Provide application name (e.g. Pyut)"
            exit 77
    fi
}

function validateParameters() {
    PROJECT_DIR=${1}
    APPLICATION_NAME=${2}

    doParamsExist ${PROJECT_DIR} ${APPLICATION_NAME}

    # does project directory exist?
    FULL_PROJECT_DIR="${PROJECTS_BASE}/${PROJECT_DIR}"

    if [ ! -d "${FULL_PROJECT_DIR}" ]; then
        printError "${FULL_PROJECT_DIR} directory does not exist"
        exit 88
    fi
    FULL_APP_NAME="${FULL_PROJECT_DIR}/dist/${APPLICATION_NAME}.app"
    if [ ! -d "${FULL_APP_NAME}" ]; then
        printError "${FULL_APP_NAME} application does not exist"
        exit 99
    fi
}