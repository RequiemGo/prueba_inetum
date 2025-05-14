# README

**NOTA:** Para generar el token usar el email de "andres.castillo@inetum.com" y la contraseña de "password" (sin comillas)

La Documentación del API está en la parte final del readme

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


## 📄Documentación de APIs

importar el siguiente JSON en Postman

1. Abre Postman.

2. En la pantalla principal, haz clic en "Import" (esquina superior izquierda).

2. Selecciona la pestaña "Raw text".

Copia solo la parte JSON desde el README:

```bash
{
  "info": {
    "name": "UserTaskAPI",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Login",
      "request": {
        "method": "POST",
        "header": [],
        "body": {
          "mode": "urlencoded",
          "urlencoded": [
            { "key": "email", "value": "andres.castillo@inetum.com", "type": "text" },
            { "key": "password", "value": "password", "type": "text" }
          ]
        },
        "url": {
          "raw": "http://localhost:3000/api/v1/login",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["api", "v1", "login"]
        }
      }
    },
    {
      "name": "List Tasks",
      "request": {
        "method": "GET",
        "header": [
          {
            "key": "Authorization",
            "value": "Bearer {{jwt_token}}",
            "type": "text"
          }
        ],
        "url": {
          "raw": "http://localhost:3000/api/v1/tasks",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["api", "v1", "tasks"]
        }
      }
    },
    {
      "name": "Logout",
      "request": {
        "method": "DELETE",
        "header": [
          {
            "key": "Authorization",
            "value": "Bearer {{jwt_token}}",
            "type": "text"
          }
        ],
        "url": {
          "raw": "http://localhost:3000/api/v1/logout",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["api", "v1", "logout"]
        }
      }
    }
  ]
}
```
GraphQL

```bash
POST http://localhost:3000/graphql
```
raw
```bash
{
  "query": "mutation ($input: UpdateTaskInput!) { updateTask(input: $input) { id title status } }",
  "variables": {
    "input": { "id": 3, "status": "done" }
  }
}
```

- ejemplo de muatción

```bash
mutation {
  createTask(input: {
    userId: 1,
    title: "Aprender GraphQL",
    description: "Una descripción",
    status: "PENDING",
    dueDate: "2025-06-30"
  }) {
    id
    title
  }
}
```

