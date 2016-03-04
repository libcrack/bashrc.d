export JAVA_HOME="/usr/lib/jvm/default"
export PATH="${JAVA_HOME}/bin:${PATH}"
export CACERTS="$(readlink -e $(dirname $(readlink -e $(which keytool)))/../lib/security/cacerts)"

# keytool -list -keystore /etc/ssl/certs/java/cacerts -storepass changeit

java_cacerts_list()
{
    if keytool -list -keystore $CACERTS -storepass changeit > /dev/null ; then
        echo $CACERTS
    else
        echo "Can not find cacerts file." >&2
        return 1
    fi
}

