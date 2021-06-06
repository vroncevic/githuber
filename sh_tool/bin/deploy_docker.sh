#!/bin/bash
#
# @brief   Project structure formater
# @version ver.2.0
# @date    Tue Apr 22 21:14:20 CEST 2016
# @company None, free software to use 2016
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Deploy docker scripts for github project
# @param  Values required github dir, project name, and util configuration
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# deploy_docker $GITHUB_DIR $PRO_NAME config_githuber_util
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
function deploy_docker {
    local -n DATA_REF=$1
    local GITHUB_DIR=$2
    local PRO_NAME=$3
    local FUNC=${FUNCNAME[0]} MSG="None"
    if [[ -n "${GITHUB_DIR}" && -n "${PRO_NAME}" ]]; then
        local DOCKER_FILE TEMPLATE_FILE STATUS
        DOCKER_FILE="${GITHUB_DIR}/create_docker_image.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_IMG_CREATE]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        DOCKER_FILE="${GITHUB_DIR}/create_docker_container.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_CONT_CREATE]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        DOCKER_FILE="${GITHUB_DIR}/push_docker_image.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_IMG_PUSH]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        DOCKER_FILE="${GITHUB_DIR}/stop_docker_container.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_STOP]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        DOCKER_FILE="${GITHUB_DIR}/remove_docker_container.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_CONT_REMOVE]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        DOCKER_FILE="${GITHUB_DIR}/remove_docker_image.sh"
        TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[DOCKER_IMG_REMOVE]}"
        MSG="Generating file [${DOCKER_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE_FILE $DOCKER_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Failed to deploy docker scripts"
            info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
            return $NOT_SUCCESS
        fi
        if [[ "${GITHUB_DIR}" == *"python"* ]]; then
            local PYP_DEPLOY="${GITHUB_DIR}/pypi_deploy.sh"
            TEMPLATE_FILE="${GITHUBER_HOME}/conf/${DATA_REF[PYP_DEPLOY]}"
            MSG="Generating file [${PYP_DEPLOY}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
            drop_to_file $TEMPLATE_FILE $PYP_DEPLOY
            STATUS=$?
            if [ $STATUS -eq $NOT_SUCCESS ]; then
                MSG="Failed to deploy docker scripts"
                info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
                return $NOT_SUCCESS
            fi
        fi
        return $STATUS
    fi
    MSG="Failed to deploy docker scripts"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
