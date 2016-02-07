#
# echo kill -TERM $(cat /run/redsocks/redsocks.pid) && rm /run/redsocks/redsocks.pid
# /usr/bin/redsocks -t -c /etc/redsocks.conf
# /usr/bin/redsocks -c /etc/redsocks.conf -p /run/redsocks/redsocks.pid

myredsocks(){
    dev="br0"
    ip="172.19.19.143"
    redsocks=31338
    burp=8080

    [ `whoami` == "root" ] || { echo "NEED ROOT"; return 1; }

    test -e /run/redsocks/redsocks.pid || {
        echo Arrancando
        su redsocks -c "/usr/bin/redsocks \
            -c /etc/redsocks.conf \
            -p /run/redsocks/redsocks.pid"
    }

    # echo 1 > /proc/sys/net/ipv4/ip_forward
    iptables -v -t nat -F
    # iptables -v -t nat -A POSTROUTING -d 0.0.0.0/0 -s $ip -j MASQUERADE
    iptables -v -t nat -A PREROUTING -p tcp -s $ip --dport 80  -j REDIRECT --to-ports $burp
    iptables -v -t nat -A PREROUTING -p tcp -s $ip --dport 443  -j REDIRECT --to-ports $burp
    #iptables -v -t nat -A PREROUTING -p tcp -s $ip --dport 5228  -j REDIRECT --to-ports $burp
    #iptables -v -t nat -A PREROUTING -p tcp -s $ip --dport 5000  -j REDIRECT --to-ports $burp
    #iptables -v -t nat -A PREROUTING -p tcp -s $ip -j REDIRECT --to-ports $burp
    iptables -v -t nat -A PREROUTING -p tcp -s $ip -j REDIRECT --to-ports $redsocks
    #iptables -v -A FORWARD -p tcp -s $ip -j LOG --log-prefix "redsocks DROP "
    #iptables -v -A FORWARD -p tcp -s $ip -j DROP
    echo tail -f /var/log/redsocks.log \| ccze -A \&
}
