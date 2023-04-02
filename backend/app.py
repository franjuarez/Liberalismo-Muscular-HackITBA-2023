#Dependencias:
#fastapi
#uvicorn

from fastapi import FastAPI
from pydantic import BaseModel
import json
# from random_pass_generator import generate_password

app = FastAPI()

        
database = {}

@app.get("/")
def read_root():
    return {"probando": "backend"}

"""
post: nos brindas el username y dominio (pass si hace falta) para que nosotros nos encarguemos de crear una nueva y cambiarla
get: 
"""

@app.post('/cambiar_contrasena')
async def cambiar_contrasena(usuario, dominio):
    return {'new_password': '1234'}


@app.post('/change_password')
async def change_password(usuario, dominio):
    #usuario = login.usuario
    #dominio = login.dominio
    #new_password = generate_password()
    new_password = "1234"
    #LLAMAR A CRIS CON EL USUARIO (MAIL) Y DOMINIO A CAMBIAR
    return {'new_password': new_password}

#esta me deveulve la password del usuario y su dominio.
@app.get("/get_password")
async def give_password(user: str, domain: str):
    if domain not in database[user]:
        pass #Tirar except?
    return database[user][domain] #esta es la password



