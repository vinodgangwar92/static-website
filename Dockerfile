# Start with the official Nginx image
FROM nginx:alpine

# Copy all your website files into Nginx folder
COPY . /usr/share/nginx/html

# Expose port 80 (HTTP)
EXPOSE 80
