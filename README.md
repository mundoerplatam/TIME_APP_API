# ⏱️ Time App API

Proyecto API para la gestión de partes de horas (timesheet) de equipos de trabajo, desarrollada con FastAPI y PostgreSQL.

## 🔍 Objetivo

Crear una API REST robusta, conectada a base relacional, preparada para ser usada desde apps low-code, Google Sheets o frontends personalizados.

---

## 📦 Estructura del Proyecto

- `/sql`: scripts SQL de creación de tablas y datos base.
- `/app`: backend FastAPI con endpoints y lógica de negocio.
- `/data`: CSV y JSON para pruebas o importación.
- `/docs`: documentación técnica y roadmap.
- `/tests`: tests de endpoints (pytest o similar).

---

## 🚀 Cómo levantar el proyecto

```bash
# 1. Crear entorno virtual
python -m venv venv
source venv/bin/activate  # en Windows: venv\Scripts\activate

# 2. Instalar dependencias
pip install -r requirements.txt

# 3. Levantar la API
uvicorn app.main:app --reload
```

Visitar: [http://localhost:8000/docs](http://localhost:8000/docs) para la documentación interactiva Swagger.

---

## 🛠️ Stack usado

- Python 3.10+
- FastAPI
- PostgreSQL
- Pydantic
- Uvicorn
- SQL DDL modular
- Postman (para testeo)
- GitHub + VS Code

---

## 📅 Roadmap

Ver archivo: `docs/roadmap.md` o el archivo original `roadmap_sql_api_lowcode_python.md`

---

## ✍️ Autor

[Alex Zajaron](https://github.com/eugenioklimenok) | Proyecto formativo y portafolio personal.
