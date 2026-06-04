FROM coredns/coredns:latest

COPY <<EOF /Corefile
. {
    forward . 1.1.1.1 1.0.0.1
    log
}
EOF
