FROM debian:buster

RUN apt-get update && apt-get install -y --no-install-recommends \
    python-minimal \
    python-pip \
    zsh \
    sudo \
    aptitude \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG user=test
ARG repository=ansible-asdf

# Configura pipefail para tuberías
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create test user and directory
RUN useradd -m "${user}" -s /bin/bash \
 && echo "${user}:${user}" | chpasswd \
 && adduser "${user}" sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
 && touch /home/"${user}"/.zshrc \
 && chown -R "${user}":"${user}" /home/"${user}" \
 && mkdir -p /home/"${user}"/"${repository}" \
 && chown -R "${user}":"${user}" /home/"${user}"/"${repository}"

VOLUME ["/home/${user}/${repository}"]

ARG ansible_version="<2.9.0,!=2.8.6"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN pip install --no-cache-dir ansible=="${ANSIBLE_VERSION}"

CMD ["/bin/bash", "-c", "trap : TERM INT; sleep infinity & wait"]
