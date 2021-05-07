import sqlite3
import os

class FirstDB:
    def __init__(self):
        self.conn = sqlite3.connect('first.db')
        self.cur = self.conn.cursor()

    def get_name(self, user_id:str) -> str:
        self.cur.execute('SELECT name FROM first WHERE user_id=?', (user_id,))
        data = self.cur.fetchone()
        return data[0]

    def add_name(self, first_name:str, user_id:str) -> None:
        self.cur.execute('INSERT INTO first (name, user_id) VALUES (?, ?)', (first_name,user_id))
        self.conn.commit()
        return None

    def remove_name(self, user_id:str) -> None:
        self.cur.execute('DELETE FROM first WHERE userid = ?',(user_id,))
        self.conn.commit()
        return None

    def setup_db(self) -> None:
        self.cur.execute('''CREATE TABLE IF NOT EXISTS "first" (
            "name"	TEXT,
            "user_id"	TEXT,
            PRIMARY KEY("user_id")
            );''')
        self.conn.commit()
        return None

class LastDB:
    def __init__(self):
        self.conn = sqlite3.connect('last.db')
        self.cur = self.conn.cursor()

    def get_name(self, user_id:str) -> str:
        self.cur.execute('SELECT name FROM last WHERE user_id=?', (user_id,))
        data = self.cur.fetchone()
        return data[0]

    def add_name(self, last_name:str, user_id:str) -> None:
        self.cur.execute('INSERT INTO last (name, user_id) VALUES (?, ?)', (first_name,user_id))
        self.conn.commit()
        return None

    def remove_name(self, user_id:str) -> None:
        self.cur.execute('DELETE FROM last WHERE userid = ?',(user_id,))
        self.conn.commit()
        return None

    def setup_db(self) -> None:
        self.cur.execute('''CREATE TABLE IF NOT EXISTS "last" (
            "name"	TEXT,
            "user_id"	TEXT,
            PRIMARY KEY("user_id")
            );''')
        self.conn.commit()
        return None