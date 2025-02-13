# 1️⃣ Use an official lightweight Python image as the base
FROM python:3.9-slim
RUN pip install --upgrade pip

# 2️⃣ Set environment variables to prevent Python from writing .pyc files and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3️⃣ Set the working directory in the container
WORKDIR /app

# 4️⃣ Copy only requirements first for better caching
COPY requirements.txt .

# 5️⃣ Install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 6️⃣ Copy the rest of the application code into the container
COPY . .

# 7️⃣ Expose the port Flask runs on (optional, but recommended for documentation)
EXPOSE 5000

# 8️⃣ Set Flask environment variables
ENV FLASK_APP=run.py
ENV FLASK_ENV=production

# 9️⃣ Default command to run the Flask app using Gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "run:app"]
