import sqlite3
import os
from sqlite3.dbapi2 import IntegrityError

class FirstDB:
    def __init__(self):
        self.conn = sqlite3.connect('app/first.db')
        self.cur = self.conn.cursor()

    def get_name(self, user_id:str) -> str:
        self.cur.execute('SELECT name FROM first WHERE user_id=?', (user_id,))
        data = self.cur.fetchone()
        if data is None:
            raise AssertionError
        return data[0]

    def add_name(self, first_name:str, user_id:str) -> None:
        try:
            self.cur.execute('INSERT INTO first (name, user_id) VALUES (?, ?)', (first_name,user_id))
            self.conn.commit()
            return None
        except IntegrityError:
            # User ID already exists so raise AssertionError
            raise AssertionError
            
    def remove_name(self, user_id:str) -> None:
        self.cur.execute('DELETE FROM first WHERE user_id = ?',(user_id,))
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
        self.conn = sqlite3.connect('app/last.db')
        self.cur = self.conn.cursor()

    def get_name(self, user_id:str) -> str:
        self.cur.execute('SELECT name FROM last WHERE user_id=?', (user_id,))
        data = self.cur.fetchone()
        if data is None:
            raise AssertionError
        return data[0]

    def add_name(self, last_name:str, user_id:str) -> None:
        try:
            self.cur.execute('INSERT INTO last (name, user_id) VALUES (?, ?)', (last_name ,user_id))
            self.conn.commit()
            return None
        except IntegrityError:
            raise AssertionError

    def remove_name(self, user_id:str) -> None:
        self.cur.execute('DELETE FROM last WHERE userid = ?', (user_id,))
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

class EmailDB:
    def __init__(self):
        self.conn = sqlite3.connect('app/email.db')
        self.cur = self.conn.cursor()
        self.domain = os.getenv('email_domain')

    def get_email(self, user_id:str) -> str:
        self.cur.execute('SELECT email FROM email WHERE user_id=?', (user_id,))
        data = self.cur.fetchone()
        if data is None:
            raise AssertionError
        return data[0]

    def add_email(self, first_name:str, last_name:str, user_id:str) -> None:
        try:
            email_address = f"{first_name}.{last_name}@{self.domain}"
            self.cur.execute('INSERT INTO email (email, user_id) VALUES (?, ?)', (email_address ,user_id))
            self.conn.commit()
        except IntegrityError:
            raise AssertionError

    def remove_email(self, user_id:str) -> None:
        self.cur.execute('DELETE FROM email WHERE userid = ?', (user_id,))
        self.conn.commit()
        return None

    def setup_db(self) -> None:
        self.cur.execute('''CREATE TABLE IF NOT EXISTS "email" (
            "email"	TEXT,
            "user_id"	TEXT,
            PRIMARY KEY("user_id")
            );''')
        self.conn.commit()
        return None