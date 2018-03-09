# dockerized-docs-nginx

# What is it? #
Dockerzied Nginx documentation for offline use.

# Image description #
- Base image: `centos/httpd-24-centos7`
- The https://nginx.org and https://docs.nginx.com are mirrored using httrack 

# How to use this image #

```console
$ docker run -d genadipost/dockerized-docs-nginx
```

You can test it by visiting http://container-ip:8080
