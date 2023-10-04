#!/bin/sh

# -----------------------------
# aliases / helpers / variables
# -----------------------------

# The following alias is meant for rc options we'll always set unconditionally
# so the UI will work
tw='task rc.defaultwidth=0 rc.defaultheight=0 rc.verbose=nothing rc._forcecolor=on'

maximum_unsupported_fzf_version=0.18.0
fzf_version="$(fzf --version)"
if printf "${maximum_unsupported_fzf_version}\n%s" $fzf_version | sort -V | tail -1 | grep -q ${maximum_unsupported_fzf_version}; then
	echo taskfzf: Your fzf version "($fzf_version)" is not supported >&2
	echo taskfzf: Please install 0.19.0 or higher from https://github.com/junegunn/fzf/releases >&2
	exit 1
fi

# Make all less invocations interpret ANSI colors
export LESS="-r"

print_taskwarrior_bug_info(){
	cat >&2 <<EOF
Due to a bug in taskwarrior, taskwarrior-fzf was not able to get the filter of the
Current context correctly. See https://github.com/GothenburgBitFactory/taskwarrior/issues/2219

To workaround the issue, use contexts without dashes (-) in your ~/.taskrc. The
context parsed was $1

Use \`A\` to add a task without attempting to get attributes from current context.
EOF
}

basename="$(basename $0)"

if [ "${_TASKFZF_SHOW}" = "keys" ]; then
	echo KEY $'\t'Action
	echo === $'\t'======
	echo D$'\t\t'"Mark tasks as Done"
	echo X$'\t\t'"Delete tasks"
	echo U$'\t\t'"Undo last action"
	echo E$'\t\t'"Edit selected tasks with \$EDITOR"
	echo T$'\t\t'"Add a new task"
	echo I$'\t\t'"Add a new task, with context of the currently highlighted task"
	echo A$'\t\t'"Append to first selected task"
	echo N$'\t\t'"Annotate the first selected task"
	echo M$'\t\t'"Modify the first selected task"
	echo R$'\t\t'"Change report"
	echo C$'\t\t'"Change context"
	echo CTRL-R$'\t'"Reload the current report"
	echo S$'\t\t'"Start task"
	echo P$'\t\t'"Stop task"
	echo ?$'\t\t'"Show keys"
	exit 0
fi

# set a file path that it's content will mark how to execute the next command
# in the main loop
current_filter=${XDG_RUNTIME_DIR:-${XDG_CACHE_DIR:-${TMP-/tmp}}}/taskfzf-current-filter
if ! touch $current_filter; then
	echo "${basename}: Can't create a marker file needed for internal state management." >&2
	echo "${basename}: It's default location according to your environment is $current_filter" >&2
	echo "${basename}: Please update either of the following environment variables so the file will be creatable." >&2
	echo "${basename}: TMP" >&2
	echo "${basename}: XDG_RUNTIME_DIR" >&2
	echo "${basename}: XDG_CACHE_DIR" >&2
	exit 3
fi

# --------------------------------------------------------------------------
# If a _TASKFZF_ environmental variables is set (see explanation near
# the main loop at the end), we'll need to do the following:
# --------------------------------------------------------------------------

# we'd want to quit after the action upon the tasks was made and only if we are not changing the list we are viewing
if [ -n "$_TASKFZF_TASK_ACT" ]; then
	# We clear the screen from previous output so it'll be easy to see what
	# taskwarrior printed when doing the actions below.
	clear
	# checks if the arguments given to the task are numbers only
	if [ "$_TASKFZF_REPORT" = "all" ]; then
		tasks_args=$(grep -o '[0-9a-f]\{8\}' $@ | tr '\n' ' ')
	else
		tasks_args=$(awk '{printf $1" "} END {printf "\n"}' $@)
	fi
	case "$tasks_args" in
		^[a-f0-9])
			echo "${basename}: chosen tasks: $tasks_args"
			echo "${basename}: Unless your report is 'all', you should use reports with numbers at their first columns."
			echo "${basename}: Please update your taskrc so all of your reports will print the task's ID/UUID at the left most column."
			echo "${basename}: Or, alternatively, choose a line that has a number in it's beginning."
			echo ---------------------------------------------------------------------------
			echo Press any key to continue
			read
			exit $?
			;;
	esac
	# Other actions (such as edit / append etc) can't be used upon multiple tasks
	case "$_TASKFZF_TASK_ACT" in
		modify|append|annotate)
			if [ "$tasks_args" = "${tasks_args%% *}" ]; then
				tasks_args="${tasks_args%% *}"
				clear
				echo "${basename}: WARNING: Only the first task ($tasks_args) will be used when $_TASKFZF_TASK_ACT -ing it."
				echo ---------------------------------------------------------------------------
				echo Press any key to continue
				read
			fi
			;;
	esac
	# Actually perform the actions upon the tasks
	case "$_TASKFZF_TASK_ACT" in
		undo)
			# Doesn't need arguments
			task undo
			;;
		add)
			# Needs no arguments but does need a prompt
			echo "Add task:"
			echo ---------
			read -p "set tags or project? " attribute_args
			read -p "Task description: " description_args
			task "$attribute_args" add "$description_args"
			;;
		add-with-context)
			context="$(sed 's/rc.context=\([^ ]\+\).*/\1/' "${current_filter}")"
			case $context in
				*-*)
					print_taskwarrior_bug_info "$context"
					;;
				*)
					context_attributes="$(task _get rc.context."$context")"
					echo "Add task with attributes:"
					echo "$context_attributes"
					echo ---------
					read -p "set additional attributes? " attribute_args
					read -p "Task description: " description_args
					task "$context_attributes" "$attribute_args" add "$description_args"
			esac
			;;
		append|modify|annotate)
			echo "Run command:"
			read -p "task $tasks_args $_TASKFZF_TASK_ACT " args
			task $tasks_args "$_TASKFZF_TASK_ACT" "$args"
			;;
		*)
			task $tasks_args "$_TASKFZF_TASK_ACT"
			;;
	esac
	# Prints a banner for after action view - it's a dirty and dumb version of
	# piping to less.
	echo ---------------------------------------------------------------------------
	echo End of \`task "$_TASKFZF_TASK_ACT"\` output. Press any key to continue
	read
	exit $?
fi

if [ -n "$_TASKFZF_LIST_CHANGE" ]; then
	# We'll generate a tiny bit different string to save in our marker file in
	# the case we are changing the report or the context
	case $_TASKFZF_LIST_CHANGE in
		report)
			report_str="$($tw reports | sed '$d' | fzf --ansi --no-multi \
				--bind='enter:execute@echo {1}@+abort' \
			)"
			;;
		context)
			context_str='rc.context='"$($tw context | fzf --ansi --no-multi \
				--bind='enter:execute@echo {1}@+abort' \
			)"
			;;
	esac

	# We save the next command line arguments for the next, outer loop
	echo "$context_str" "$report_str" > $current_filter
	exit
fi

if [ -n "$_TASKFZF_RELOAD" ]; then
	filter="$(cat "$current_filter")"
	output=$($tw $filter)
	# If there's no output at all, fzf be unusable saying something like:
	# [Command failed: env _TASKFZF_RELOAD=true ./taskfzf]
	# Hence, we check it first and print a more gracefull message instead
	if [ -n "$output" ]; then
		echo "$output"
	else
		echo No tasks were found in filter $filter
	fi
	exit
fi

# We remove the marker file so we'll be able to know once inside the loop
# whether this is an initial execution of our program or not. We can't use the
# variables _TASKFZF_LIST_CHANGE and _TASKFZF_TASK_ACT themselves since we exit
# if either of these variables is set and so we let go the outer loop continue
# to execute.
if [ -z "${_TASKFZF_LIST_CHANGE+1}" ] && [ -z "${_TASKFZF_TASK_ACT+1}" ] && [ "${_TASKFZF_INTERNAL}" != "reload" ]; then
	rm -f $current_filter
fi

# -------------------------
# Here starts the real shit
# -------------------------

# Every binding in fzf's interface, calls this very script with a special
# environment variable _TASKFZF_TASK_ACT set to the appropriate value. This is
# how we essentially accomplish 'helpers' which fzf needs to execute as
# standalone scripts because it's a program and not a pure shell function.

# While Ctrl-c wasn't pressed inside fzf
while [ $? != 130 ]; do

	# If the marker file does exists, it's because the variables
	# _TASKFZF_TASK_ACT / _TASKFZF_LIST_CHANGE or _TASKFZF_INTERNAL were set.
	# That's why we get the arguments for tw from there.
	if [ -w "$current_filter" ]; then
		tw_args="$(cat $current_filter)"
	else
		# otherwise, we can rest assure this is the initial run of this program and so: 
		tw_args="$@"
		# Save the current filter used as in our marker file for the next execution
		echo "$tw_args" > $current_filter
	fi

	# all is a type of report we need to apply some heuristics to, we at least
	# try to detect it as so, see
	# https://gitlab.com/doronbehar/taskwarrior-fzf/-/issues/8#note_339724564
	case "$tw_args" in
		*all*) export _TASKFZF_REPORT=all ;;
	esac
	# If we are supposed to reload the list, we count on the if procedure of
	# current_filter to load the current arguments in $tw_args, and we use it
	# here
	if [ "${_TASKFZF_INTERNAL}" = "reload" ]; then
		$tw $tw_args
		exit $?
	fi
	# A few things to notice: 
	# 
	# - See https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983
	# for an explanation of that tty redirection.
	#
	# - We add a 'print-query' action after 'execute' so this fzf process will
	# quit afterwards, leaving space for the next iteration of the loop. We
	# can't use abort because otherwise we'll get $? == 130 and the loop will
	# quit.
	#
	# - We use {+f} instead of {+} because it's easier to parse a file
	# containing the lines chosen instead of one line containing all lines
	# chosen given as a CLI argument
	$tw $tw_args | fzf --ansi \
		--multi \
		--bind="D:execute(env _TASKFZF_TASK_ACT=do $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="X:execute(env _TASKFZF_TASK_ACT=delete $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="U:execute(env _TASKFZF_TASK_ACT=undo $0< /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="E:execute(env _TASKFZF_TASK_ACT=edit $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="T:execute(env _TASKFZF_TASK_ACT=add $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="I:execute(env _TASKFZF_TASK_ACT=add-with-context $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="A:execute(env _TASKFZF_TASK_ACT=append $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="N:execute(env _TASKFZF_TASK_ACT=annotate $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="M:execute(env _TASKFZF_TASK_ACT=modify $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="S:execute(env _TASKFZF_TASK_ACT=start $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="P:execute(env _TASKFZF_TASK_ACT=stop $0 {+f} < /dev/tty > /dev/tty 2>&1 )+print-query" \
		--bind="R:execute(env _TASKFZF_LIST_CHANGE=report $0)+reload(env _TASKFZF_RELOAD=true $0)" \
		--bind="C:execute(env _TASKFZF_LIST_CHANGE=context $0)+reload(env _TASKFZF_RELOAD=true $0)" \
		--bind="ctrl-r:reload(env _TASKFZF_INTERNAL=reload $0)" \
		--bind="?:execute(env _TASKFZF_SHOW=keys $0 | less)+print-query" \
		--bind="enter:execute(env _TASKFZF_TASK_ACT=information $0 {+f} | less)"
done
