FROM fabioluciano/alpine-base-java
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="WSO2 - Base"

###

ARG wso2_esb_version
ENV wso2_esb_version ${wso2_esb_version:-"5.0.0"}

ARG wso2_repository_version
ENV wso2_repository_version ${wso2_repository_version:-"4.4.11"}

ARG wso2_registry_version
ENV wso2_registry_version ${wso2_registry_version:-"5.4.0"}

ARG wso2_username
ENV wso2_username ${wso2_username:-"wso2"}

ARG wso2_password
ENV wso2_password ${wso2_password:-"password"}

ARG wso2_component_directory
ENV wso2_component_directory ${wso2_component_directory:-"/opt/wso2/"}

###

RUN apk --update --no-cache add openssh \
  && mkdir -p /opt/wso2/

WORKDIR /opt

## Configure SSH
RUN printf "${wso2_password}\n${wso2_password}" | adduser ${wso2_username} \
  && printf "\n\n" | ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
  && printf "\n\n" | ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
  && printf "\n\n" | ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
  && printf "\n\n" | ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
  && echo "AllowUsers ${wso2_username}" >> /etc/ssh/sshd_config
