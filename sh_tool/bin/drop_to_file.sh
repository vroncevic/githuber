#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Drop processed template content to file
# @param  Values required template path and source path
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# drop_to_file template/pypi_deploy.template pypi_deploy.sh
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
function drop_to_file {
    local TEMPLATE_FILE=$1
    local SOURCE_FILE=$2
    if [[ -n "${TEMPLATE_FILE}" && -n "${SOURCE_FILE}" ]]; then
        local SOURCE_LINE
        while read SOURCE_LINE
        do
            eval echo "$SOURCE_LINE" >> ${SOURCE_FILE}
        done < ${TEMPLATE_FILE}
        return $SUCCESS
    fi
    return $NOT_SUCCESS
}
