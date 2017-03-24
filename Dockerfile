FROM jenkinsci/jnlp-slave:2.62

ARG KUBECTL_VERSION=v1.5.2

USER root

RUN apt-get update && apt-get install -y make && apt-get install -y build-essential g++

RUN curl -LO https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz \
	&& tar xzf kubernetes-client-linux-amd64.tar.gz \
	&& rm kubernetes-client-linux-amd64.tar.gz \
	&& chmod +x ./kubernetes/client/bin/kubectl \
	&& mv ./kubernetes/client/bin/kubectl /usr/local/bin/kubectl \
	&& rm -Rf ./kubernetes

COPY COMODORSACertificationAuthority.crt /usr/local/share/ca-certificates/
COPY COMODORSADomainValidationSecureServerCA.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates