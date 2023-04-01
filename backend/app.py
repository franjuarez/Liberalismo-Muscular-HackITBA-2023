from fastapi import FastAPI
from pydantic import BaseModel
import json

app = FastAPI()

#La idea es tener de Database un diccionario con una tupla del sitio y password, la clave sería el str del username
# y como valor un diccionario con las tuplas (username, password) 
database = {}

@app.get("/")
def read_root():
    return {"probando": "backend"}

@app.get("/users")
async def get_users():
    json_str = json.dumps(database)
    return json_str

@app.post("/add_password")
async def add_password(user: str, domain: str, username: str, password: str):
    if user not in database:
        database[user] = {}
    database[user][domain] = (username, password)
    return {"message": "Password succesfully added"}





