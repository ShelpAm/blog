# Stage 1: Build the Jekyll site
FROM ruby:3.3-alpine AS builder

RUN apk add --no-cache \
    build-base \
    git

WORKDIR /site

COPY Gemfile* ./
RUN gem install bundler && bundle install

COPY . .

RUN bash tools/test.sh

# Stage 2: Serve the static site with nginx
FROM nginx:alpine AS server

COPY --from=builder /site/_site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
