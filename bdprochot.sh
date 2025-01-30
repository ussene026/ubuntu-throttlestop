# Log File
LOGFILE="/var/log/bdprochot.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

log_message() {
    echo "$DATE - $1" >> $LOGFILE
}

log_message "Starting BD-PROCHOT deactivation"

msr_values=$(sudo rdmsr -a -d 0x1FC)

if [ $? -ne 0 ]; then
    log_message "Error reading MSR register 0x1FC"
    exit 1
fi

new_values=""
for value in $msr_values; do
    new_value=$((value - 1))
    sudo wrmsr 0x1FC $new_value
    new_values="$new_values$new_value "
done

log_message "BD-PROCHOT successfully disabled (Previous value: $msr_values, new value: $new_values)"

exit 0