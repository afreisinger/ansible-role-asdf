FROM debian:stretch

RUN apt-get update && apt-get install -y \
    python-minimal \
    python-pip \
    zsh \
    sudo \
    aptitude \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG user=test
ARG repository=ansible-asdf

# Create test user
RUN useradd -m ${user} -s /bin/bash \
 && echo "${user}:${user}" | chpasswd \
 && adduser ${user} sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN touch /home/${user}/.zshrc \
 && chown -R ${user}:${user} /home/${user}

# Create directory for code
RUN mkdir -p /home/${user}/${repository} \
 && chown -R ${user}:${user} /home/${user}/${repository}
VOLUME ["/home/${user}/${repository}"]

ARG ansible_version="<2.9.0,!=2.8.6"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN pip install --no-cache-dir ansible${ANSIBLE_VERSION}

CMD ["/bin/bash", "-c", "trap : TERM INT; sleep infinity & wait"]
