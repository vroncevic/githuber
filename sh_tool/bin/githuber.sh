#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
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
GITHUBER_VERSION=ver.4.2
GITHUBER_HOME=${UTIL_ROOT}/${GITHUBER_TOOL}/${GITHUBER_VERSION}
GITHUBER_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}.cfg
GITHUBER_UTIL_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}_util.cfg
GITHUBER_LOGO=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}.logo
GITHUBER_LOG=${GITHUBER_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${GITHUBER_HOME}/bin/center.sh
.    ${GITHUBER_HOME}/bin/display_logo.sh
.    ${GITHUBER_HOME}/bin/drop_to_file.sh
.    ${GITHUBER_HOME}/bin/deploy_guide.sh
.    ${GITHUBER_HOME}/bin/deploy_setup.sh
.    ${GITHUBER_HOME}/bin/deploy_docker.sh
.    ${GITHUBER_HOME}/bin/deploy_build_py.sh
.    ${GITHUBER_HOME}/bin/deploy_venv.sh
.    ${GITHUBER_HOME}/bin/deploy_codecov.sh

declare -A GITHUBER_USAGE=(
    [USAGE_TOOL]="${GITHUBER_TOOL}"
    [USAGE_ARG1]="[PRPJECT AREA] Devel area: bash, cc++, perl, python, ..."
    [USAGE_ARG2]="[PRO_DIR NAME] Fullname of project"
    [USAGE_ARG3]="[PRO_DIR NAME PREFIX] Prefix name of project (optional)"
    [USAGE_ARG4]="[PRO_DIR NAME POSTFIX] Postfix name of project (optional)"
    [USAGE_EX_PRE]="# Creating project structure"
    [USAGE_EX]="${GITHUBER_TOOL} python GtkWindow"
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
#            0   - finished with success operation
#            127 - run as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing area in configuration file
#            131 - missing devel root directory
#            132 - missing area directory
#            133 - project already exist
#            134 - failed to deploy setup script
#            135 - failed to deploy guide info
#            136 - failed to deploy docker scripts
#            137 - failed to deploy build py scripts
#            138 - failed to deploy venv scripts
#            139 - failed to deploy codecov scripts
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __githuber python GtkWindow
#
function __githuber {
    local PRO_AREA=$1 PRO_NAME=$2 PRO_NAME_PREFIX=$3 PRO_NAME_POSTFIX=$4
    display_logo
    if [[ -n "${PRO_AREA}" && -n "${PRO_NAME}" ]]; then
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
        check_key ${PRO_AREA} ${AREAS}
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
            exit 130
        fi
        local DEV_DIR=${config_githuber_util[PROJECT_DEV_ROOT]}
        MSG="Checking directory [${DEV_DIR}/]?"
        info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
        if [ -d "${DEV_DIR}/" ]; then
            MSG="[ok]"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            local AREA_DEV_DIR="${DEV_DIR}/${PRO_AREA}"
            MSG="Checking directory [${AREA_DEV_DIR}/]?"
            info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
            if [ -d "${AREA_DEV_DIR}/" ]; then
                MSG="[ok]"
                info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
                local PRO_DIR="${AREA_DEV_DIR}/${PRO_NAME}"
                if [ ! -d "${PRO_DIR}/" ]; then
                    MSG="Generating directory [${PRO_DIR}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${PRO_DIR}/"
                    local T="    " H="#" DATE=`date` TREE USERID GROUPID
                    local BRIEF VERSION COMPANY AUTHOR_NAME AUTHOR_EMAIL
                    BRIEF=${config_githuber_util[BRIEF]}
                    VERSION=${config_githuber_util[VERSION]}
                    COMPANY=${config_githuber_util[COMPANY]}
                    AUTHOR_NAME=${config_githuber_util[AUTHOR_NAME]}
                    AUTHOR_EMAIL=${config_githuber_util[AUTHOR_EMAIL]}
                    USERID=${config_githuber_util[USERID]}
                    GROUPID=${config_githuber_util[GROUPID]}
                    deploy_setup config_githuber_util $PRO_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 134
                    fi
                    deploy_guide config_githuber_util $PRO_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 135
                    fi
                    local DOCS_DIR="${PRO_DIR}/docs"
                    MSG="Generating directory [${DOCS_DIR}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${DOCS_DIR}/"
                    local GITHUB_DIR="${PRO_DIR}/github"
                    MSG="Generating directory [${GITHUB_DIR}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${GITHUB_DIR}/"
                    local GITHUB_PRO_DIR="${PRO_DIR}/github/${PRO_NAME}/"
                    MSG="Generating directory [${GITHUB_PRO_DIR}/]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    mkdir "${GITHUB_PRO_DIR}/"
                    deploy_docker config_githuber_util $GITHUB_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 136
                    fi
                    deploy_build_py config_githuber_util $GITHUB_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 137
                    fi
                    deploy_venv config_githuber_util $GITHUB_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 138
                    fi
                    deploy_codecov config_githuber_util $GITHUB_DIR $PRO_NAME
                    STATUS=$?
                    if [ $STATUS -eq $NOT_SUCCESS ]; then
                        MSG="Force exit!"
                        info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
                        exit 139
                    fi
                    MSG="Set owner!"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    eval "chown -R ${USERID}.${GROUPID} ${PRO_DIR}/"
                    MSG="Set permission!"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                    eval "chmod -R 700 ${PRO_DIR}/"
                    MSG="Generated project: ${PRO_NAME} at area ${PRO_AREA}"
                    GITHUBER_LOGGING[LOG_MSGE]=$MSG
                    logging GITHUBER_LOGGING
                    info_debug_message_end "Done" "$FUNC" "$GITHUBER_TOOL"
                    TREE=$(which tree)
                    check_tool "${TREE}"
                    STATUS=$?
                    if [ $STATUS -eq $SUCCESS ]; then
                        eval "${TREE} -L 3 ${PRO_DIR}/"
                    fi
                    exit 0
                fi
                MSG="[not ok]"
                info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
                MSG="Project already exist [${PRO_DIR}/]"
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
# @brief   Main entry point of tool githuber
# @params  Values required project area and project name
# @exitval Script tool githuber exit with integer value 0 - 136
#
printf "\n%s\n%s\n\n" "${GITHUBER_TOOL} ${GITHUBER_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __githuber $1 $2 $3 $4
fi

exit 127
