FROM httpd:latest
MAINTAINER Ron Cohen <roncohen04@gmail.com>

# Install httrack to get docs
RUN apt-get update && apt-get install -y httrack original-awk

# Get the nginx docs sites
RUN mkdir /usr/local/nginx-docs /usr/local/nginx-docs/nginx-com \
    && cd /usr/local/nginx-docs && httrack https://nginx.org/ \
    && cd /usr/local/nginx-docs/nginx-com && httrack https://www.nginx.com/resources/admin-guide/

# Set httpd to nginx-docs
RUN rm -rf /usr/local/apache2/htdocs && ln -s /usr/local/nginx-docs /usr/local/apache2/htdocs \
    && cd /usr/local/nginx-docs &&  mv nginx-com/www.nginx.com/ nginx.com

# Connect between sites com and org
RUN cd /usr/local/nginx-docs \ 
    && cat nginx.org/en/docs/index.html \
    | awk '{gsub(/"https\:\/\/www\.nginx\.com\/resources\/admin-guide\/"/, "\"/nginx.com/resources/admin-guide/index.html\"")}1' > tmp.html \
    && rm -rf nginx.org/en/docs/index.html && cp tmp.html nginx.org/en/docs/index.html

# remove httrack
RUN apt-get remove -y httrack original-awk

EXPOSE 80
