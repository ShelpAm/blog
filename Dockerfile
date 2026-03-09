FROM debian

RUN apt-get install ruby-full build-essential zlib1g-dev git

RUN cat <<EOF >> ~/.profile \
  # Install Ruby Gems to ~/gems \
  export GEM_HOME="$HOME/gems" \
  export PATH="$HOME/gems/bin:$PATH" \
  EOF \
  source ~/.profile

COPY * ./

RUN gem install jekyll bundler
RUN bundle

RUN pip install -r requirements.txt
