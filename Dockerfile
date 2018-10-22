# https://hub.docker.com/r/gitlab/gitlab-ce/tags/
FROM gitlab/gitlab-ce:10.2.2-ce.0

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
RUN cd /opt/gitlab/embedded/bin/ && ./gem install -i /opt/gitlab/embedded/service/gem/ruby/2.1.0 mysql2 -v0.3.17 \
	&& mv /opt/gitlab/embedded/service/gitlab-rails/.bundle/config /opt/gitlab/embedded/service/gitlab-rails/.bundle/config.old \
	&& sed -e 's/mysql/postgres/' /opt/gitlab/embedded/service/gitlab-rails/.bundle/config.old > /opt/gitlab/embedded/service/gitlab-rails/.bundle/config \
	&& cd /opt/gitlab/embedded/service/gitlab-rails && /opt/gitlab/embedded/bin/bundle install

COPY assets /assets/
RUN chmod +x /assets/*.sh

EXPOSE 80 22

CMD /assets/foilen_wrapper.sh
