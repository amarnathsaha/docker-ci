# Stage 1: Build stage
FROM python:slim as builder

# Install Flask and other dependencies
RUN pip install --no-cache-dir flask==3.0.*

# Stage 2: Production stage
FROM python:slim

# Copy the installed Flask from the builder stage
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin/flask /usr/local/bin/flask

# Copy the application code
COPY hello.py /

# Set environment variables
ENV FLASK_APP=hello

# Expose the port
EXPOSE 8000

# Command to run the Flask app
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "8000"]
