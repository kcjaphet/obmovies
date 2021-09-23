# pull official base image
FROM python:3.8

# create directory for the app user
RUN mkdir -p /app

# create the appropriate directories
ENV HOME=/app
ENV APP_HOME=/app/web
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY requirements.txt .
# Lint
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn

# copy project
COPY . $APP_HOME

# chown all the files to the app user
RUN adduser  app
RUN chown -R app:app $HOME
RUN chmod -R 755 $APP_HOME

# change to the app user
USER app
#ENTRYPOINT [ "python" ]
#CMD [ "./obmovies/run.py" ]
CMD [ "gunicorn", "-w", "4", "--bind", "0.0.0.0:5000"]