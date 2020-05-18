#!/bin/sh

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO=/mnt/BorgBackups/ArcoLinux

# See the section "Passphrase notes" for more infos.
export BORG_PASSPHRASE='saldfh877Dhfb#K8ddBSJ'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM
info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create							\
	--verbose                      \
    --progress						\
	--list							\
	--filter=AME					\
	--stats                         \
    --show-rc                       \
    --compression zstd,9			\
    --exclude-caches                \
    --exclude '/home/*/.cache/*'    \
    --exclude '/var/cache/*'        \
    --exclude '/var/tmp/*'          \
									\
	::"{hostname}-$(date +%F_%R)"			\
	/boot							\
    /etc                            \
    /home                           \
    /root                           \
	/usr							\
    /var                            \
	/mnt/SharedHome					\
	2>&1 | tr "\r" "\n" > /home/adl/.logs/borg/log_$(date +%F_%R)

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'	        \
    --show-rc						\
	--keep-last		14				\
    --keep-daily    14              \
    --keep-weekly   8               \
    --keep-monthly  8	            \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
