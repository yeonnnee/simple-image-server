# Pull the minimal Ubuntu image
FROM nginx

# Copy the Nginx config
WORKDIR /etc/nginx
COPY images/  ./images/
# COPY images.tar.gz ./
# RUN tar -xf ./images.tar.gz \
#  && rm -rf ./images.tar.gz
#  ADD images.tar.gz ./ 하면 자동으로 압축 해제됨

COPY nginx.conf ./

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]