FROM debian

# Set working directory
WORKDIR /opt/blog/
COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        ruby-full build-essential zlib1g-dev git python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Ruby gems
ENV GEM_HOME=/root/gems
ENV PATH="$GEM_HOME/bin:$PATH"

# Install Ruby gems and Python dependencies
RUN gem install jekyll bundler
RUN bundle install
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

# Incoming traffic on port 9001 for the webhook server
EXPOSE 9001

# Run the webhook server
CMD ["python3", "tools/webhook_server.py", "_site"]
