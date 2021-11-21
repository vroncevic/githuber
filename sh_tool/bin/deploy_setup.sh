#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.1
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Deploy setup script for github project
# @param  Values required project dir, project name, and util configuration
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# deploy_setup $PRO_DIR $PRO_NAME config_githuber_util
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
function deploy_setup {
    local -n DATA_REF=$1
    local PRO_DIR=$2
    local PRO_NAME=$3
    local FUNC=${FUNCNAME[0]} MSG="None"
    if [[ -n "${PRO_DIR}" && -n "${PRO_NAME}" ]]; then
        local SETUP_FILE TEMPLATE_FILE
        SETUP_FILE="${PRO_DIR}/${PRO_NAME}_setup.sh"
        if [[ "${PRO_DIR}" == *"python"* ]]; then
            TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[SETUP_PY]}"
        else
            TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[SETUP_SH]}"
        fi
        MSG="Generating file [${SETUP_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $SETUP_FILE
        local STATUS=$?
        return $STATUS
    fi
    MSG="Failed to deploy setup script"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
