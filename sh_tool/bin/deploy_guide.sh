#!/bin/bash
#
# @brief   Project structure formater
# @version ver.2.1
# @date    Tue Apr 22 21:14:20 CEST 2016
# @company None, free software to use 2016
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  deploy guide info file for github project
# @param  Values required project dir, project name, and util configuration
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# deploy_guide $PRO_DIR $PRO_NAME config_githuber_util
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
function deploy_guide {
    local -n DATA_REF=$1
    local PRO_DIR=$2
    local PRO_NAME=$3
    local FUNC=${FUNCNAME[0]} MSG="None"
    if [[ -n "${PRO_DIR}" && -n "${PRO_NAME}" ]]; then
        local GUIDE_FILE TEMPLATE_FILE
        GUIDE_FILE="${PRO_DIR}/${PRO_NAME}_git.txt"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[GUIDELINE]}"
        MSG="Generating file [${GUIDE_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $GUIDE_FILE
        local STATUS=$?
        return $STATUS
    fi
    MSG="Failed to deploy guide info"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
