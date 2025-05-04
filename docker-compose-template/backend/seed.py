import os
from base import SessionLocal, User
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


HOST = os.environ.get('DB_HOST', '0.0.0.0')
DB = os.environ.get('POSTGRES_DB', 'promda')
USER = os.environ.get('POSTGRES_USER', 'promda')
PSWD = os.environ.get('POSTGRES_PASSWORD', 'promda')

SQLALCHEMY_DATABASE_URL = f"postgresql://{USER}:{PSWD}@{HOST}:5432/{DB}"




engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

db = SessionLocal()

users = [
    User(login='pavel', email='a@gmail.com', hashed_password='pavel_a'),
    User(login='yura', email='b@gmail.com', hashed_password='yura_b'),
]

for user in users:
    if not db.query(User).filter_by(email=user.email).first():
        db.add(user)

db.commit()
db.close()
