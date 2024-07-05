#!/bin/bash
#
# @brief   Project structure formater
# @version ver.4.2
# @date    Sun 21 Nov 2021 10:27:58 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Display logo
# @param  Additional shifter - new tab which should be added
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# center 0
#
function center {
    local ADDITIONAL_SHIFTER=$1
    local START_POSITION=$((${CONSOLE_WIDTH} / 2 - 21))
    local NUMBER_OF_TABS=$((
        ${START_POSITION} / 4 - 1 + ${ADDITIONAL_SHIFTER}
    ))
    local TAB="$(printf '\011')"
    for ((I = 0; I <= ${NUMBER_OF_TABS}; I++))
    do
        printf "${TAB}"
    done
}
