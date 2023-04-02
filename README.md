# Liberalismo-Muscular-HackITBA-2023

Lamentablemente no llegamos con el tiempo para hacer que el programa compile. En el video explayamos la idea que seguimos, acá detallamos como la intentamos implementar. Realizamos un frontend en Flutter y un backend en FastAPI. La idea fue crear una password manager app que se encargaba de constantemente chequear las bases de datos fitradas y en caso de haber encontrado algun perfil del usuario, cambiarle instantaneamente su contraseña. Pudimos levantar la app y crear el bot que a través de un script de Selenium cambiaba la constraseña de Facebook de un perfil elegido. Lo que nos perjudicó fue la API, a pesar de HORAS debuggeando no pudimos hacer que se reconozca el dominio del backend y así poder pasar datos entre Front y Back. 
Debajo igualmente dejamos las instrucciones que sirven para poder correr el proyecto 

INstrucciones para correr los archivos: 
Backend:
pip install fastapi
pip install uvicorn
correr en terminal: uvicorn app:app --host 0.0.0.0 --port 8000
para encontrar donde esta hosteado el server hay que encontrar la IP local y poner en el buscador: {IP}:8000.
Para ver la IP local es tan facil como entrar al CMD y poner "ipconfig".
Frontend: 
Necesario: Dart SDK 3.0.0-384.0.dev --->Para descargar este se descarga Flutter y en el CMD hay que usar el comando "dart channel master" y despues usar el comando "flutter upgrade".
Despues para tener las dependecias necesarias para correr el archivo en Flutter hay que correr el comando: "flutter pub get
