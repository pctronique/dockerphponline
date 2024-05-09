# variable environnement
ARG VALUE_MAILHOG_VERSION
ARG DEF_MAILHOG_VERSION=${VALUE_MAILHOG_VERSION:-"v1.0.0"}

# config install nodejs
FROM mailhog/mailhog:${DEF_MAILHOG_VERSION}

USER root

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]
