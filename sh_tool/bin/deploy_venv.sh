#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Deploy venv script for github project
# @param  Values required util configuration, project dir and project name 
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# deploy_venv config_githuber_util $PRO_DIR $PRO_NAME
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#    # true
# else
#    # false
#    # missing argument | wrong argument
#    # return $NOT_SUCCESS
#    # or
#    # exit 128
# fi
#
function deploy_venv {
    local -n DATA_REF=$1
    local GITHUB_DIR=$2
    local PRO_NAME=$3
    local FUNC=${FUNCNAME[0]} MSG="None"
    if [[ "${GITHUB_DIR}" != *"python"* ]]; then
        return $SUCCESS
    fi
    if [[ -n "${GITHUB_DIR}" && -n "${PRO_NAME}" ]]; then
        local SETUP_FILE TEMPLATE_FILE
        local STATUS=$NOT_SUCCESS
        SETUP_FILE="${GITHUB_DIR}/venv_create.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[VENV_CREATE]}"
        MSG="Generating file [${SETUP_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $SETUP_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Faile generation of file [${SETUP_FILE}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        fi
        SETUP_FILE="${GITHUB_DIR}/venv_helper.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[VENV_HELP]}"
        MSG="Generating file [${SETUP_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $SETUP_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Faile generation of file [${SETUP_FILE}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        fi
        return $STATUS
    fi
    MSG="Failed to deploy venv script(s)"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
