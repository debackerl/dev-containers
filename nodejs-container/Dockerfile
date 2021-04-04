FROM node:14.16-buster

# see prerequisites for VS Code Remote SSH: https://code.visualstudio.com/docs/remote/linux#_remote-host-container-wsl-linux-prerequisites
# https://code.visualstudio.com/docs/remote/ssh-tutorial
# https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md
# try: https://github.com/microsoft/vscode-remote-try-node

RUN apt-get update && \
    apt-get install -y openssh-server vim nano htop rsync openssl curl wget python3 awscli mariadb-client postgresql-client bash bash-completion g++ make git && \
    rm -rf /var/lib/apt/lists/*

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "AcceptEnv LANG LC_*" >> /etc/ssh/sshd_config && \
    echo "PidFile none" >> /etc/ssh/sshd_config && \
    adduser --shell /bin/bash --disabled-password --gecos "First Last,RoomNumber,WorkPhone,HomePhone" developer && \
    mkdir -m 0700 /home/developer/.ssh && \
    cp /etc/ssh/sshd_config /home/developer/.ssh/ && \
    echo "HostKey /home/developer/.ssh/ssh_host_dsa_key" >> /home/developer/.ssh/sshd_config && \
    echo "HostKey /home/developer/.ssh/ssh_host_ecdsa_key" >> /home/developer/.ssh/sshd_config && \
    echo "HostKey /home/developer/.ssh/ssh_host_ed25519_key" >> /home/developer/.ssh/sshd_config && \
    echo "HostKey /home/developer/.ssh/ssh_host_rsa_key" >> /home/developer/.ssh/sshd_config && \
    chown -R developer:developer /home/developer/.ssh

COPY entrypoint.sh /sbin

USER developer

RUN mkdir /home/developer/.npm-packages && \
    npm config set prefix "/home/developer/.npm-packages" && \
    echo "NPM_PACKAGES=\"/home/developer/.npm-packages\"" >> /home/developer/.bashrc && \
    echo "export PATH=\"\$PATH:\$NPM_PACKAGES/bin\"" >> /home/developer/.bashrc

ENTRYPOINT [ "/bin/bash" ]
