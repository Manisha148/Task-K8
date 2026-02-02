#FROM  centos:7
#RUN yum update -y
#RUN yum install -y httpd \
#zip \
#unzip
#RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
#ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
#WORKDIR /var/www/html/

#RUN unzip photogenic.zip
#RUN cp -rvf photogenic/* .
#RUN rm -rf photogenic photogenic.zip
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#EXPOSE 9090


# Use the official Python base image as the base image
FROM public.ecr.aws/docker/library/python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire Python app to the container
COPY . .

# Set the entry point for the container
CMD ["python", "app.py"]

