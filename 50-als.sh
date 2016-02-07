#!/bin/bash
# Author: Cata <xkill@locolandia.net>
# Description: Change the ALS status (HP laptop)

als-toggle(){

    LOGGER="/usr/bin/logger"
    APP=$0

    ALSDEV="/sys/devices/platform/hp-wmi/als"
    EXIT=0

    if [ -f $ALSDEV -a -r $ALSDEV ]
    then
        STATUS=`cat $ALSDEV`
        case "$STATUS" in
            "0")
                $LOGGER -i "ALS status is disabled"
                ;;
            "1")
                $LOGGER -i "ALS status is enabled"
                ;;
            *)
                $LOGGER -p user.err -i "ALS: unkown status [$STATUS]"
                ;;
        esac
    else
            $LOGGER -p user.err -i "ALS: Can't read status at file $ALSDEV, check if module hp-wmi is loaded"
    fi

    if [ -w $ALSDEV ]
    then
        case "$STATUS" in
            "0")
                echo 1 > $ALSDEV && \
                $LOGGER -i "ALS status changed: now is enabled" || \
                $LOGGER -p user.err -i "Error changing ALS status to enabled"
                ;;
            "1")
                echo 0 > $ALSDEV && \
                $LOGGER -i "ALS status changed: now is disabled" || \
                $LOGGER -p user.err -i "Error changing ALS status to disabled"
                ;;
            *)
                $LOGGER -p user.err -i "ALS: unkown status [$STATUS]"
                ;;
        esac
    else
            $LOGGER -p user.err -i  "ALS: Can't change the status at file $ALSDEV, check if your user have permisions."
    fi
}
