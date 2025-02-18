FROM python:3.13-slim

WORKDIR /code

# Combine package installations and cleanup
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt && \
    # Optional: Clean up after installation to reduce image size
    rm requirements.txt  # Remove requirements.txt after installation

# Copy source code *after* installing dependencies.
COPY src/ .

# Run tests in a separate layer
RUN pytest app

EXPOSE 5000

CMD ["fastapi", "run", "app/main.py", "--port", "5000"]

