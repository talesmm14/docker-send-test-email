FROM python:3.10
LABEL authors="tales melquiades"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN mkdir /app/static
RUN mkdir /app/media

RUN apt-get update

RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"

# install dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi --no-root --without dev

# copy and run program
COPY . /app/
CMD ["poetry", "run", "python", "-m", "main"]
CMD ["poetry", "run", "python", "manage.py", "sendtestemail", "${EMAIL_TEST_SEND}"]