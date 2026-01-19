# Start with the official Nginx image
FROM nginx:alpine

# Remove Nginx default web files
RUN rm -rf /usr/share/nginx/html/*

# Copy all your website files into Nginx folder
COPY . /usr/share/nginx/html

# Expose port 80 (HTTP)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
