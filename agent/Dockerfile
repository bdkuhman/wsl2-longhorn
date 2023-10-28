FROM rancher/k3s:v1.27.6-k3s1 as k3s

FROM ubuntu:22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV TZ=$TZ

RUN apt-get update
RUN apt-get install -y nfs-common open-iscsi ca-certificates

RUN uname -r >> kernel.txt

RUN mv /usr/bin/mount /tmp/mount
RUN mv /usr/bin/tar /tmp/tar

COPY --from=k3s /bin/* /bin/
COPY --from=k3s /etc/* /etc/

RUN mv  /tmp/mount /usr/bin/mount
RUN mv  /tmp/tar /usr/bin/tar


RUN mkdir -p /etc && \
    echo 'hosts: files dns' > /etc/nsswitch.conf

RUN chmod 1777 /tmp

VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log

ENV PATH="$PATH:/bin/aux"

RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session

ADD --chown=root:root --chmod=644 ./k3s-agent.service  /etc/systemd/system/
ADD --chown=root:root --chmod=600 ./k3s-agent.service.env  /etc/systemd/system/

ADD --chown=root:root --chmod=755 ./entrypoint.sh /entrypoint.sh 
RUN systemctl enable k3s-agent

RUN update-ca-certificates

CMD ["/sbin/init"]