from fastapi import FastAPI
from pydantic import BaseModel
import json
from random_pass_generator import generate_password

app = FastAPI()

class Login:
    def __init__(self, usuario: str, dominio: str):
        self.usuario = usuario
        self.dominio = dominio
        
database = {}

@app.get("/")
def read_root():
    return {"probando": "backend"}

"""
post: nos brindas el username y dominio (pass si hace falta) para que nosotros nos encarguemos de crear una nueva y cambiarla
get: 
"""

#esta es al pedo
@app.get("/users")
async def get_users():
    json_str = json.dumps(database)
    return json_str


# #una vez que se agrega un domain, se agrega el username y password
# @app.post("/add_account")
# async def add_account(data: json):
#     domain = data["domain"]
#     username = data["username"]
#     password = data["password"]
#     database[domain] = (username, password)
#     return {"message": "Password succesfully added"}

@app.post('/change_password')
async def change_password(login: Login):
    usuario = login.usuario
    dominio = login.dominio
    new_password = generate_password()
    #LLAMAR A CRIS CON EL USUARIO (MAIL) Y DOMINIO A CAMBIAR
    return {'new_password': new_password}

#esta me deveulve la password del usuario y su dominio.
@app.get("/get_password")
async def give_password(user: str, domain: str):
    if domain not in database[user]:
        pass #Tirar except?
    return database[user][domain] #esta es la password



