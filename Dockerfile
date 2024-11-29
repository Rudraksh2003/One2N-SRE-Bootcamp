FROM python:3.9-slim
WORKDIR /app
COPY ./static/requirements.txt .
RUN pip install --no-cache-dir gunicorn
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 500
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=production
CMD [ "gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app" ]