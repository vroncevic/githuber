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
UTIL=${UTIL_ROOT}/sh_util/$UTIL_VERSION
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/send_mail.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh

GITHUBER_TOOL=githuber
GITHUBER_VERSION=ver.1.0
GITHUBER_HOME=${UTIL_ROOT}/${GITHUBER_TOOL}/${GITHUBER_VERSION}
GITHUBER_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}.cfg
GITHUBER_UTIL_CFG=${GITHUBER_HOME}/conf/${GITHUBER_TOOL}_util.cfg
GITHUBER_LOG=${GITHUBER_HOME}/log

declare -A GITHUBER_USAGE=(
	[USAGE_TOOL]="${GITHUBER_TOOL}"
	[USAGE_ARG1]="[PAREA] Dev area: bash | perl | python | cc++"
	[USAGE_ARG2]="[PNAME] Fullname of project"
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

#
# @brief   Main function 
# @params  Values required project area and project name
# @exitval Function __githuber exit with integer value
#			0   - tool finished with success operation 
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from files
#			130 - project already exist
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __githuber perl GtkWindow
#
function __githuber() {
	local PAREA=$1 PNAME=$2
	if [[ -n "${PAREA}" && -n "${PNAME}" ]]; then
		local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
		MSG="Loading basic and util configuration!"
		__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
		__progress_bar PB_STRUCTURE
		declare -A config_githuber=()
		__load_conf "$GITHUBER_CFG" config_githuber
		STATUS_CONF=$?
		declare -A config_githuber_util=()
		__load_util_conf "$GITHUBER_UTIL_CFG" config_githuber_util
		STATUS_CONF_UTIL=$?
		declare -A STATUS_STRUCTURE=(
			[1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
		)
		__check_status STATUS_STRUCTURE
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
			exit 129
		fi
		local DATE=`date` RDEVDIR=${config_githuber_util[PROJECT_DEV_ROOT]}
		MSG="Checking directory [${RDEVDIR}/]?"
		__info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
		if [ -d "${RDEVDIR}/" ]; then
			MSG="[ok]"
			__info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
			local ADIR="${RDEVDIR}/${PAREA}"
			MSG="Checking directory [${ADIR}/]?"
			__info_debug_message_que "$MSG" "$FUNC" "$GITHUBER_TOOL"
			if [ -d "${ADIR}/" ]; then
				MSG="[ok]"
				__info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
				local PROJECT="${ADIR}/${PNAME}"
				if [ ! -d "${PROJECT}/" ]; then
					MSG="Creating directory [${PROJECT}/]!"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					mkdir "${PROJECT}/"
					MSG="Creating setup script!"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					local SLINE GLINE BRIEF VERSION COMPANY AUTHOR TAB="	"
					local GUIDE=${config_githuber_util[GUIDELINE_TEMPLATE]}
					local SETUP=${config_githuber_util[SETUP_TEMPLATE]} HASH="#"
					BRIEF=${config_githuber_util[BRIEF]}
					VERSION=${config_githuber_util[VERSION]}
					COMPANY=${config_githuber_util[COMPANY]}
					AUTHOR=${config_githuber_util[AUTHOR]}
					while read SLINE
					do
						eval echo "$SLINE" >> "${PROJECT}/${PNAME}_setup.sh"
					done < "${GITHUBER_HOME}/conf/${SETUP}"
					MSG="Creating GIT help file!"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					while read GLINE
					do
						eval echo "$GLINE" >> "${PROJECT}/${PNAME}_git.txt"
					done < "${GITHUBER_HOME}/conf/${GUIDE}"
					MSG="Creating directory [${PROJECT}/github/]"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					mkdir "${PROJECT}/github/"
					MSG="Setting owner!"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					local USRID=${config_githuber_util[UID]}
					local GRPID=${config_githuber_util[GID]}
					eval "chown -R ${USRID}.${GRPID} ${PROJECT}/"
					MSG="Setting permissions"
					__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
					eval "chmod -R 700 ${PROJECT}/"
					__info_debug_message_end "Done" "$FUNC" "$GITHUBER_TOOL"
					exit 0
				fi
				MSG="[not ok]"
				__info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
				MSG="Project already exist [${PROJECT}/]!"
				__info_debug_message "$MSG" "$FUNC" "$GITHUBER_TOOL"
				MSG="Force exit!"
				__info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
				exit 130
			fi
			MSG="[not ok]"
			__info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
		fi
		MSG="[not ok]"
		__info_debug_message_ans "$MSG" "$FUNC" "$GITHUBER_TOOL"
		MSG="Force exit!"
		__info_debug_message_end "$MSG" "$FUNC" "$GITHUBER_TOOL"
	fi
	__usage GITHUBER_USAGE
	exit 128
}

#
# @brief   Main entry point of script tool
# @params  Values required project area and project name
# @exitval Script tool githuber exit with integer value
#			0   - tool finished with success operation 
# 			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from files
#			130 - project already exist
#
printf "\n%s\n%s\n\n" "${GITHUBER_TOOL} ${GITHUBER_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__githuber $1 $2
fi

exit 127

