FROM ubuntu:16.04

ENV BUILD_PACKAGES bash ruby-dev libgl1-mesa-glx
ENV RUBY_PACKAGES ruby ruby-bundler
ENV PYTHON_PACKAGES python3 python3-dev python3-setuptools python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas

RUN apt-get update && \
    apt-get install -y curl build-essential libpng12-dev libffi-dev  && \
    apt-get install -y $BUILD_PACKAGES && \
    apt-get install -y --no-install-recommends $RUBY_PACKAGES && \
    apt-get install -y --no-install-recommends $PYTHON_PACKAGES && \
    apt-get clean && \

    # clean up
    rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log && \

    # Setup Rubygems
    echo 'gem: --no-document' > /etc/gemrc && \
    gem install bundler && gem update --system

RUN pip3 install scikit-learn

RUN mkdir /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/

COPY . /usr/app

WORKDIR /usr/app

RUN bundle config --global silence_root_warning 1
RUN bundle install --system

CMD ["ruby"]
