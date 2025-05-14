# README
# Backend User Task API

API en Rails 8 con autenticación JWT (creada co la gema **jwt** y **bcrypt**), tareas y usuarios. Incluye endpoints REST y también soporte para GraphQL.

---

### 🚀 Cómo ejecutar el proyecto con Docker

Para levantar la app localmente usando Docker:

```bash
docker compose up --build
```
Eso construye la imagen y arranca dos servicios:

-  web: el servidor Rails

- db: una base de datos PostgreSQL persistente

Después de eso, la API estará disponible en:

```bash
http://localhost:3000
```
Si necesitas reiniciar:

```bash
docker compose down
docker compose up
```
Para acceder a la consola Rails:

```bash
docker compose exec web rails console
```
### 🧪 Cómo correr las pruebas

Una vez que el contenedor esté levantado, puedes ejecutar los tests con:

```bash
docker compose exec web bundle exec rspec
```
Esto corre toda la suite de pruebas usando RSpec. También puedes correr archivos individuales como este:

```bash
docker compose exec web bundle exec rspec spec/requests/api/v1/tasks_request_spec.rb
```
### 🧠 Arquitectura y decisiones técnicas

- Se usó Rails 8 (API only) y ruby 3.4.1

- La base de datos es PostgreSQL (volumen persistente).

- La autenticación se maneja con JWT sin depender de gemas como Devise.

- Se implementaron dos formas de consumir datos:

  - REST (/api/v1/*)

  - GraphQL (/graphql)

- Toda la app está dockerizada.


- El código está con RSpec y se cubren endpoints principales como login, tareas y usuarios.

- El historial Git está organizado con commits atómicos.
