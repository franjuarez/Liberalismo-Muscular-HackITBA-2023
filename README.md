# Liberalismo-Muscular-HackITBA-2023

La app sigue en desarrollo.

Realizamos un frontend en Flutter y un backend en FastAPI. Se trata de un password manager app que se encarga de constantemente chequear las bases de datos fitradas y en caso de haber encontrado algun perfil del usuario, cambiarle instantaneamente su contraseña. Por ahora se puede cambiar la contraseña de Facebook a través de un script de Selenium. La API sigue en trabajo.

Debajo estan las instrucciones que sirven para poder correr el proyecto.

Instrucciones para correr los archivos: 
Backend:
pip install fastapi
pip install uvicorn
correr en terminal: uvicorn app:app --host 0.0.0.0 --port 8000
para encontrar donde esta hosteado el server hay que encontrar la IP local y poner en el buscador: {IP}:8000.
Para ver la IP local es tan facil como entrar al CMD y poner "ipconfig".
Frontend: 
Necesario: Dart SDK 3.0.0-384.0.dev --->Para descargar este se descarga Flutter y en el CMD hay que usar el comando "dart channel master" y despues usar el comando "flutter upgrade".
Despues para tener las dependecias necesarias para correr el archivo en Flutter hay que correr el comando: "flutter pub get
