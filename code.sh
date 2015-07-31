#!/bin/bash  

START=$(date +%s)
LINE="------------------- ------------------- ------------------- -------------------"
SMALL_LINE="------------------- -------------------"

CMD_BUILD_SKIP_TEST="mvn -T 4C clean install -Dmaven.test.skip=true"
CMD_BUILD="git pull"

case $1 in
	
	t|T)		
		# This command will execute given command in multi threading mode, with default 20 threads.
		echo -e "\n** Executing [$CMD_BUILD] on all repo in multi threading mode ** \n $SMALL_LINE \n Please wait for few seconds."
		
		find . -type d -name '.git' -print0 | xargs -P 20 -n 1 -0 -I '{}' sh -c "cd \"{}\"/../ && $CMD_BUILD && pwd && echo -e '\n' " \;
        ;;
		
	build|BUILD)
		# This command will execute given command in multi threading mode, with default 20 threads. It will also build git repo in multi threading mode with option -T 4C
		echo -e "\n** Executing [$CMD_BUILD_SKIP_TEST] on all repo in multi threading mode ** \n $SMALL_LINE \n"
		
		find . -type d -name '.git' -print0 | xargs -P 20 -n 1 -0 -I '{}' sh -c "cd \"{}\"/../ && git pull && pwd && $CMD_BUILD_SKIP_TEST && echo -e '\n' " \;
        ;;	
		
	s|S|*)
		# This is a default command which will execute git command in sequential mode.
		echo -e "\n** Executing [$CMD_BUILD] on all repo in sequential mode ** \n $SMALL_LINE \n"
				
		find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && $CMD_BUILD && echo -e '\n' " \;
        ;;

esac


END=$(date +%s)
DIFF=$(( $END - $START ))
echo $LINE
echo "Total time taken by this script: [$DIFF] seconds"
echo $LINE