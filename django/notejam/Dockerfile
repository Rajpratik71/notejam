FROM amazonlinux:2017.03
ENV LANG=en_US.UTF-8
RUN yum -y install git \
    python36 \
    python36-pip \
    zip \
    python36-devel \
    mysql \
    mysql-devel \
    gcc \
    && yum clean all
RUN python3 -m pip install --upgrade pip setuptools wheel \
    && python3 -m pip install boto3

# Set the same WORKDIR as default image
RUN mkdir /var/task
WORKDIR /var/task
