FROM smee-builder

# Use tini as the init system to handle signals properly
USER root
RUN apk add --no-cache tini \
    && chmod u+s /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "index.js"]

# Fix wrong CSS output from the builder image
ADD https://smee.io/public/index.html /usr/src/smee.io/public/index.html
ADD https://smee.io/public/main.min.css /usr/src/smee.io/public/main.min.css
RUN cd /usr/src/smee.io/public \
    && rm main.min.css.gz \
    && gzip -k main.min.css \
    && chmod 0644 * \
    && chown 1000:1000 *

# Drop back to the non-root user to run the application
USER 1000

# Set the NODE_ENV environment variable to production for better performance
ENV NODE_ENV=production
ENV PORT=8080
