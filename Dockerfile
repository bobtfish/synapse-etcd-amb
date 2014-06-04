FROM ubuntu:precise
MAINTAINER bobtfish@bobtfish.net

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq -y && \
    apt-get install -qq -y ruby1.9.3 ruby-bundler build-essential git-core iputils-ping supervisor haproxy && \
    apt-get clean

RUN git clone https://github.com/bobtfish/synapse.git;cd synapse;git checkout etcd_service_watcher;gem build *.gemspec;gem install *.gem;cd .. ; rm -r synapse

ADD /synapse.conf.json /synapse.conf.json
ADD /run.sh /run.sh
RUN chmod 755 /*.sh

ENTRYPOINT ["/run.sh"]
CMD ["run"]

