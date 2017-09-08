FROM jenkinsci/jnlp-slave:3.10-1

ARG KUBECTL_VERSION=v1.7.0
ARG HELM_VERSION=v2.5.0
ARG PROMETHEUS_VERSION=1.7.1

USER root

RUN apt-get update && apt-get install -y make && apt-get install -y build-essential g++ python-pip jq libyaml-dev libpython2.7-dev libpython-dev
RUN pip install awscli

RUN curl -LO https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz \
	&& tar xzf kubernetes-client-linux-amd64.tar.gz \
	&& rm kubernetes-client-linux-amd64.tar.gz \
	&& chmod +x ./kubernetes/client/bin/kubectl \
	&& mv ./kubernetes/client/bin/kubectl /usr/local/bin/kubectl \
	&& rm -Rf ./kubernetes

RUN curl -LO https://kubernetes-helm.storage.googleapis.com/helm-${HELM_VERSION}-linux-amd64.tar.gz \
	&& tar xzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
	&& rm helm-${HELM_VERSION}-linux-amd64.tar.gz \
	&& mv ./linux-amd64/helm /usr/local/bin/helm \
	&& rm -Rf ./linux-amd64

# Add promtool (for verifying prometheus rules)
RUN curl -LO https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && tar xzf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    && mv ./prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool /usr/local/bin/promtool \
	&& chmod +x /usr/local/bin/promtool \
    && rm -Rf ./prometheus-${PROMETHEUS_VERSION}.linux-amd64