FROM centos/ruby-25-centos7
USER root
EXPOSE 8080
COPY combined_dodcertbundle.pem /etc/pki/ca-trust/source/anchors/
RUN chmod 644 /etc/pki/ca-trust/source/anchors/combined_dodcertbundle.pem && /usr/bin/update-ca-trust
ENV RACK_ENV production \ 
    RAILS_ENV production
    GEM_HOME ~/.gem
COPY . /opt/app-root/src/
RUN scl enable rh-ruby25 "bundle install" && chmod og+rw /opt/app-root/src/db
USER default
CMD ["scl", "enable", "rh-ruby25", "./run.sh"]
