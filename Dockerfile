FROM debian
WORKDIR /opt/

RUN apt-get install ruby-full build-essential zlib1g-dev git

RUN cat <<EOF >> ~/.profile \
  # Install Ruby Gems to ~/gems \
  export GEM_HOME="$HOME/gems" \
  export PATH="$HOME/gems/bin:$PATH" \
  EOF \
  source ~/.profile

COPY . blog
RUN cd blog

RUN gem install jekyll bundler
RUN bundle

RUN pip install -r requirements.txt

RUN python tools/webhook_server.py _site
