#!/bin/bash
#
# @brief   Project structure formater
# @version ver.1.0
# @date    Tue Apr 22 21:14:20 CEST 2016
# @company None, free software to use 2016
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

GITHUBER_TOOL=githuber
GITHUBER_VERSION=ver.1.0
GITHUBER_HOME=${UTIL_ROOT}/${GITHUBER_TOOL}/${GITHUBER_VERSION}
GITHUBER_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}.cfg
GITHUBER_UTIL_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}_util.cfg
GITHUBER_LOG=${GITHUBER_HOME}/log

declare -A GITHUBER_USAGE=(
    [USAGE_TOOL]="${GITHUBER_TOOL}"
    [USAGE_ARG1]="[PRPJECT AREA] Devel area: bash, cc++, perl, python, ruby"
    [USAGE_ARG2]="[PROJECT NAME] Fullname of project"
    [USAGE_ARG3]="[PROJECT NAME PREFIX] Prefix name of project (optional)"
    [USAGE_ARG4]="[PROJECT NAME POSTFIX] Postfix name of project (optional)"
    [USAGE_EX_PRE]="# Creating project structure"
    [USAGE_EX]="${GITHUBER_TOOL} perl GtkWindow"
)

declare -A GITHUBER_LOGGING=(
    [LOG_TOOL]="${GITHUBER_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${GITHUBER_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function
# @params  Values required project area and project name
# @exitval Function __githuber exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing area in configuration file
#            131 - missing devel root directory
#            132 - missing area directory
#            133 - project already exist
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __githuber perl GtkWindow
#
function __githuber {
    local PA=$1 PN=$2 PNPRX=$3 PNPOX=$4
    if [[ -n "${PA}" && -n "${PN}" ]]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_githuber=()
        load_conf "$GITHUBER_CFG" config_githuber
        STATUS_CONF=$?
        declare -A config_githuber_util=()
        load_util_conf "$GITHUBER_UTIL_CFG" config_githuber_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=(
            [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
        )
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
            exit 129
        fi
        TOOL_DBG=${config_githuber[DEBUGGING]}
        TOOL_LOG=${config_githuber[LOGGING]}
        TOOL_NOTIFY=${config_githuber[EMAILING]}
        local AREAS=${config_githuber_util[AREAS]}
        check_key ${PA} ${AREAS}
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
            exit 130
        fi
        local DATE=`date` RDEVDIR=${config_githuber_util[PROJECT_DEV_ROOT]}
        MSG="Checking directory [${RDEVDIR}/]?"
        info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
        if [ -d "${RDEVDIR}/" ]; then
            MSG="[ok]"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            local ADIR="${RDEVDIR}/${PA}"
            MSG="Checking directory [${ADIR}/]?"
            info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
            if [ -d "${ADIR}/" ]; then
                MSG="[ok]"
                info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
                local PROJECT="${ADIR}/${PN}"
                if [ ! -d "${PROJECT}/" ]; then
                    MSG="Generating directory [${PROJECT}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${PROJECT}/"
                    local T="    " SLINE GLINE BRIEF V
                    local COMPANY H="#" AN AE SF STF
                    local GUIDE=${config_githuber_util[GUIDELINE_TEMPLATE]}
                    local SETUP=${config_githuber_util[SETUP_TEMPLATE]} TREE
                    BRIEF=${config_githuber_util[BRIEF]}
                    V=${config_githuber_util[VERSION]}
                    COMPANY=${config_githuber_util[COMPANY]}
                    AN=${config_githuber_util[AUTHOR_NAME]}
                    AE=${config_githuber_util[AUTHOR_EMAIL]}
                    SF="${PROJECT}/${PN}_setup.sh"
                    STF="${GITHUBER_HOME}/conf/${SETUP}"
                    MSG="Generating file [${SF}]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    while read SLINE
                    do
                        eval echo "$SLINE" >> ${SF}
                    done < ${STF}
                    local GF="${PROJECT}/${PN}_git.txt"
                    local GFT="${GITHUBER_HOME}/conf/${GUIDE}"
                    MSG="Generating file [${GF}]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    while read GLINE
                    do
                        eval echo "$GLINE" >> ${GF}
                    done < ${GFT}
                    local GHUB="${PROJECT}/github"
                    MSG="Generating directory [${GHUB}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${GHUB}/"
                    MSG="Set owner!"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    local USRID=${config_githuber_util[UID]}
                    local GRPID=${config_githuber_util[GID]}
                    eval "chown -R ${USRID}.${GRPID} ${PROJECT}/"
                    MSG="Set permission!"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    eval "chmod -R 700 ${PROJECT}/"
                    MSG="Generated project: ${PN} at area ${PA}"
                    GITHUBER_LOGGING[LOG_MSGE]=$MSG
                    logging GITHUBER_LOGGING
                    info_debug_message_end "Done" "$FUNC" "$GITHUBER_TOOL"
                    TREE=$(which tree)
                    check_tool "${TREE}"
                    STATUS=$?
                    if [ $STATUS -eq $SUCCESS ]; then
                        eval "${TREE} -L 3 ${PROJECT}/"
                    fi
                    exit 0
                fi
                MSG="[not ok]"
                info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
                MSG="Project already exist [${PROJECT}/]"
                info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                MSG="Force exit!"
                info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                exit 133
            fi
            MSG="[not ok]"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
            exit 132
        fi
        MSG="[not ok]"
        info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
        exit 131
    fi
    usage GITHUBER_USAGE
    exit 128
}

#
# @brief   Main entry point of script tool
# @params  Values required project area and project name
# @exitval Script tool githuber exit with integer value
#            0   - tool finished with success operation
#             127 - run tool script as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing area in configuration file
#            131 - missing devel root directory
#            132 - missing area directory
#            133 - project already exist
#
printf "\n%s\n%s\n\n" "${GITHUBER_TOOL} ${GITHUBER_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __githuber $1 $2 $3 $4
fi

exit 127

