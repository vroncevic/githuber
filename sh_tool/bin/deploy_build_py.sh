#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Display selected option
# @param  Values required message
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# option_picked "simple message"
#
function option_picked {
    local MESSAGE=${@:-"error: no message passed"}
    printf "\t\033[1m${MESSAGE}\033[0m\n\n"
}

#
# @brief  List support options for Python packages
# @param  None
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# list_py_support
#
function list_py_support {
    printf "\n\t==============================\n"
    printf "\t# [1] Python 2\n"
    printf "\t# [2] Python 3\n"
    printf "\t# [3] Python 2/3\n"
    printf "\t==============================\n"
    printf "\tSelect Python support option >\t"
}

#
# @brief  Select Python support for generation PYP
# @param  None
# @retval Selected option 1, 2, or 3
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# select_py_support
# local OPTION=$?
#
function select_py_support {
    local OPT=0
    list_py_support
    read OPT
    while [[ $OPT != '' || $OPT != *$'\n' ]]
    do
        case $OPT in
            1)
                option_picked "Option Python 2 Picked";
                break
                ;;
            2)
                option_picked "Option Python 3 Picked";
                break
                ;;
            3)
                option_picked "Option Python 2 and Python 3 Picked";
                break
                ;;
            \n)
                option_picked "Pick an option from the menu >\t";
                read opt;
                ;;
            *)
                option_picked "Pick an option from the menu >\t";
                read opt;
                ;;
        esac
    done
    return $OPT
}

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
        select_py_support
        local OPTION=$?
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
        case $OPTION in
            1)
                TEMPLATE="${GITHUBER_HOME}/conf/${DATA_REF[PYP2_BUILD]}"
                BUILD_FILE="${GITHUB_DIR}/pypi2_build.sh"
                MSG="Generating file [${BUILD_FILE}]"
                info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                drop_to_file $TEMPLATE $BUILD_FILE
                STATUS=$?
                if [ $STATUS -eq $NOT_SUCCESS ]; then
                    MSG="Faile generation of file [${BUILD_FILE}]"
                    info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
                fi
                ;;
            2)
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
                ;;
            3)
                TEMPLATE="${GITHUBER_HOME}/conf/${DATA_REF[PYP2_BUILD]}"
                BUILD_FILE="${GITHUB_DIR}/pypi2_build.sh"
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
                ;;
            *)
                option_picked "Failed to process option!";
                ;;
        esac
        return $STATUS
    fi
    MSG="Failed to deploy build script(s)"
    info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
    return $NOT_SUCCESS
}
