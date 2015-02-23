FROM dockerfile/java:oracle-java8
MAINTAINER Benjamin Cousin "b.cousin@code-troopers.com"

ENV JETTY_VERSION jetty-distribution-9.2.8.v20150217
ENV JETTY_URL http://download.eclipse.org/jetty/stable-9/dist/$JETTY_VERSION.tar.gz

# Install packages
RUN apt-get update && \
    apt-get update --fix-missing && \
    apt-get install -y wget imagemagick

# Download and install jetty
RUN wget $JETTY_URL && \
    tar -xzvf $JETTY_VERSION.tar.gz && \
    rm -rf $JETTY_VERSION.tar.gz && \
    mv $JETTY_VERSION/ /opt/jetty

# Configure Jetty user and clean up install
RUN useradd jetty && \
    chown -R jetty:jetty /opt/jetty && \
    rm -rf /opt/jetty/webapps.demo

# Set defaults for docker run
WORKDIR /opt/jetty
CMD ["java", "-jar", "start.jar", "jetty.home=/opt/jetty"]
