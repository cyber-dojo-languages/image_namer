FROM cyberdojo/ruby-base
LABEL maintainer=jon@jaggersoft.com

COPY . /app

ARG GIT_COMMIT_SHA
ENV SHA=${GIT_COMMIT_SHA}

ENTRYPOINT [ "ruby", "/app/src/name.rb" ]
