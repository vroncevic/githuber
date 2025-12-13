#!/bin/bash
#
# @brief   Project structure formater
# @version ver.5.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}

.    ${UTIL}/bin/devel.sh

GITHUBER_TOOL=githuber
GITHUBER_VERSION=ver.5.2
GITHUBER_HOME=${UTIL_ROOT}/${GITHUBER_TOOL}/${GITHUBER_VERSION}

.    ${GITHUBER_HOME}/bin/drop_to_file.sh

#
# @brief  Deploy build script for generation pyp
# @param  Values required util configuration, github dir, and project name 
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# deploy_build_py config_githuber_util $GITHUB_DIR $PRO_NAME
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
function deploy_build_py {
    local -n DATA_REF=$1
    local GITHUB_DIR=$2
    local PRO_NAME=$3
    local FUNC=${FUNCNAME[0]} MSG="None"
    if [[ "${GITHUB_DIR}" != *"python"* ]]; then
        return $SUCCESS
    fi
    if [[ -n "${GITHUB_DIR}" && -n "${PRO_NAME}" ]]; then
        local BUILD_FILE TEMPLATE
        local STATUS=$NOT_SUCCESS
        TEMPLATE="${GITHUBER_HOME}/conf/${DATA_REF[PYP_CREATE]}"
        BUILD_FILE="${GITHUB_DIR}/pypi_create.sh"
        MSG="Generating file [${BUILD_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE $BUILD_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Faile generation of file [${BUILD_FILE}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        fi
        TEMPLATE="${GITHUBER_HOME}/conf/${DATA_REF[PYP_DEPLOY]}"
        BUILD_FILE="${GITHUB_DIR}/pypi_deploy.sh"
        MSG="Generating file [${BUILD_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE $BUILD_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Faile generation of file [${BUILD_FILE}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        fi
        TEMPLATE="${GITHUBER_HOME}/conf/${DATA_REF[PYP3_BUILD]}"
        BUILD_FILE="${GITHUB_DIR}/pypi3_build.sh"
        MSG="Generating file [${BUILD_FILE}]"
        info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        drop_to_file $TEMPLATE $BUILD_FILE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Faile generation of file [${BUILD_FILE}]"
            info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
        fi
        return $STATUS
    fi
    MSG="Failed to deploy build script(s)"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
