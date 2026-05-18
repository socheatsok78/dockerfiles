FROM smee-builder

# Fix wrong CSS output from the builder image
ADD --chown=1000:1000 --chmod=0644 https://smee.io/public/main.min.css /usr/src/smee.io/public/main.min.css
RUN cd /usr/src/smee.io/public \
    && rm main.min.css.gz \
    && gzip -k main.min.css \
    && chmod 0644 * \
    && chown 1000:1000 *
