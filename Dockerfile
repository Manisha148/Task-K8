# Use Python image from Amazon Public ECR (avoids Docker Hub rate limits)
FROM public.ecr.aws/docker/library/python:3.9

# Prevent Python from writing .pyc files and enable logs to be shown instantly
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside container
WORKDIR /app

# Install system dependencies (optional, safe to keep)
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (better Docker layer caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy rest of the application code
COPY . .

# Expose app port (change if your app uses different port)
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
