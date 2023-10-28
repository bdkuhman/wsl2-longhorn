FROM ubuntu:latest

ENV WSL_COMMIT_REF=iscsi-patch

# Install dependencies
RUN apt update
RUN apt install -y git build-essential flex bison dwarves libssl-dev libelf-dev bc python3 rsync

RUN mkdir /src
WORKDIR /src

RUN git init
RUN git remote add origin https://github.com/bdkuhman/WSL2-Linux-Kernel.git

# disable auto garbage collection;
RUN git config --local gc.auto 0 

#get wsl kernel image
RUN git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +${WSL_COMMIT_REF}:refs/remotes/origin/build/linux-msft-wsl-6.1.y
RUN git checkout --progress --force -B build/linux-msft-wsl-6.1.y refs/remotes/origin/build/linux-msft-wsl-6.1.y

#Modify as needed
COPY ./mod.sh /mod.sh
RUN /mod.sh

# build
RUN make clean

# modify -j to however many jobs/cores you desire.
RUN make -j2 KCONFIG_CONFIG=Microsoft/config-wsl
RUN make modules_install headers_install