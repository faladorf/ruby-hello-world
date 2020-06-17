FROM centos/ruby-25-centos7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production
COPY . /opt/app-root/src/
ENV GEM_HOME ~/.gem
RUN curl -ks http://192.168.20.27/pub/dodcerts/combined_dodcertbundle.pem -o /etc/pki/ca-trust/source/anchors/combined_dodcertbundle.pem
RUN /usr/bin/update-ca-trust
RUN scl enable rh-ruby25 "bundle install"
CMD ["scl", "enable", "rh-ruby25", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db
USER default
