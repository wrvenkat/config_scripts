## Description ##
  This repository contains the scripts that are used to backup or resore the configuration and status information of softwares listed in the [bnr-conf](https://github.com/wrvenkat/bnr-conf) file. The scripts are called by the bnr script based on this config file.
  
## Getting Started and Contributing ##
  The scripts in this folder backup and restore the configuration information of one software.
  
#### Conventions and guidelines for creating a config script####
  * The bnr script guarantees that the files and file paths for passed are aboslute and they exist (if required).
  * The bnr script calls the config script with the following arguments and hence must consume,  
	1. 1st argument - the absolute file path for the file **or** `!` to indicate no file.  
	2. 2nd argument - the value 0 for backup and 1 for restore.
  * A config script for software `foo-bar` *should* be named as `foo-bar-bnr.sh` and a corresponding entry added to the [bnr-conf](https://github.com/wrvenkat/bnr-conf) config file.
  * A config script *should* always exit with a value - 0 for no error and 1 for failure. This exit value is used by the bnr script to determine if the backup or restore was successfuly.
  * A config script *should* never leave any background process and should always be blocking. This is because, once a config script exits, bnr script looks for an exit value to determine whether the operation was successful. Locking any resource or leaving background processes can interfere with other config scripts.
  * A config script *should* carry out all of the steps without any user intervention. (Ex: accepting a license agreement, typing a password). This should be handled by the config script itself as config scripts are executed inside a sub-shell and the user can't interact with the running script.
  * All messages output by the config script to STDIN or STDERR is retained by the bnr script for use in logging. Hence, additional error messages are encouraged and there needn't be any separate logging at the script level.
  * It is strongly recommended to test the scripts on a fresh install of the Ubuntu version it is intended to work in.
  
## Versioning ##
  Stable versions are organized along the lines of Ubuntu's version number. Ex: 16.04 etc.
  
## LICENSE ##

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
