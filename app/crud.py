from app.db import get_connection
from app.models import UserCreate

def get_users():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, username, name, email FROM users")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return [{"id": row[0], "username": row[1], "name": row[2], "email": row[3]} for row in rows]

def create_user(user: UserCreate):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO users (username, name, email) VALUES (%s, %s, %s) RETURNING id",
        (user.username, user.name, user.email)
    )
    user_id = cursor.fetchone()[0]
    conn.commit()
    cursor.close()
    conn.close()
    return {"id": user_id, "username": user.username, "name": user.name, "email": user.email}