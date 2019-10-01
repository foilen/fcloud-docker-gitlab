# https://hub.docker.com/r/gitlab/gitlab-ce/tags/
FROM gitlab/gitlab-ce:12.2.6-ce.0

RUN export TERM=dumb ; apt-get update && apt-get install -y \
      curl \
      haproxy \
      iproute2 \
      less \
      supervisor \
      unzip \
      vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY assets /assets/
RUN chmod +x /assets/*.sh

EXPOSE 80 22

CMD /assets/foilen_wrapper.sh
