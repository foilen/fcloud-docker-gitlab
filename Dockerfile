# https://hub.docker.com/r/gitlab/gitlab-ce/tags/
FROM gitlab/gitlab-ce:11.8.7-ce.0

RUN export TERM=dumb ; apt-get update && apt-get install -y \
      curl \
      gcc \
      haproxy \
      iproute2 \
      less \
      libmysqlclient-dev \
      make \
      mysql-client \
      supervisor \
      unzip \
      vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure to use MySQL
RUN cd /tmp && \
  wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.4.tar.gz && \
  tar -zxvf ruby-2.4.4.tar.gz && \
  cd ruby-2.4.4/ && \
  ./configure && make && \
  mkdir -p /opt/gitlab/embedded/lib/ruby/include/ && cp -r include/* /opt/gitlab/embedded/lib/ruby/include/ && \
  mkdir /include && cp -r .ext/include/x86_64-linux /include && \
  \
  cd /opt/gitlab/embedded/service/gitlab-rails && \
  bundle install --with mysql && \
  rm -rf /tmp/ruby-2.4.4.tar.gz /tmp/ruby-2.4.4/

COPY assets /assets/
RUN chmod +x /assets/*.sh

EXPOSE 80 22

CMD /assets/foilen_wrapper.sh
