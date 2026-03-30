import json
from abc import ABC, abstractmethod
import pickle
import os

class Person(ABC):
    def __init__(self, name):
        self.name = name

    @abstractmethod
    def menu(self, library):
        pass


class Book:
    def __init__(self, name_book, author):
        self._name_book = name_book
        self._author = author
        self.is_available = True
        self.borrowed_by = None

    @property
    def name_book(self):
        return self._name_book

    @property
    def author(self):
        return self._author
    
    def __getstate__(self):
        state = self.__dict__.copy()
        return state
    
    def __setstate__(self, state):
        self.__dict__.update(state)

class User(Person):
    def __init__(self, username):
        super().__init__(username)
        self.borrowed_books = []

    @property
    def username(self):
        return self.name

    def menu(self, library):
        user = library.find_user(self.username)
        if not user:
            print("Пользователь не найден. Обратитесь к библиотекарю.")
            return

        while True:
            print(f"\nМеню пользователя")
            print("1. Просмотреть доступные книги")
            print("2. Взять книгу")
            print("3. Вернуть книгу")
            print("4. Просмотреть мои книги")
            print("5. Выйти")

            choice = input("Выберите действие: ")

            if choice == '1':
                print("\nДоступные книги:")
                available_books = [book for book in library.books if book.is_available]
                if available_books:
                    for i, book in enumerate(available_books, 1):
                        print(f"{i}. '{book.name_book}' - {book.author}")
                else:
                    print("Нет доступных книг")

            elif choice == '2':
                title = input("Название книги: ").strip()
                library.get_book(title, self.username)

            elif choice == '3':
                if not user.borrowed_books:
                    print("У вас нет взятых книг")
                    continue

                print("Ваши книги:")
                for i, title in enumerate(user.borrowed_books, 1):
                    print(f"{i}. {title}")

                try:
                    idx = int(input("Номер книги для возврата: ")) - 1
                    if 0 <= idx < len(user.borrowed_books):
                        title = user.borrowed_books[idx]
                        library.return_book(title, self.username)
                    else:
                        print("Неверный номер")
                except ValueError:
                    print("Ошибка ввода")

            elif choice == '4':
                if user.borrowed_books:
                    print("\nВаши книги:")
                    for i, title in enumerate(user.borrowed_books, 1):
                        print(f"{i}. {title}")
                else:
                    print("У вас нет взятых книг")

            elif choice == '5':
                break
            else:
                print("Неверный выбор")

    def __getstate__(self):
        state = self.__dict__.copy()
        return state
    
    def __setstate__(self, state):
        self.__dict__.update(state)

class Library:
    def __init__(self):
        self._books = []
        self._users = []
        self._load_data()

    @property
    def books(self):
        return self._books

    @property
    def users(self):
        return self._users

    def _save_data(self):
        try:
            with open('library_books.pkl', 'wb') as f:
                pickle.dump(self._books, f)

            with open('library_users.pkl', 'wb') as f:
                pickle.dump(self._users, f)
            
            print("Данные успешно сохранены")
        except Exception as e:
            print(f"Ошибка при сохранении данных: {e}")

    def _load_data(self):
        try:
            if os.path.exists('library_books.pkl'):
                with open('library_books.pkl', 'rb') as f:
                    self._books = pickle.load(f)
                print(f"книги успешно загружены")
                with open('library_books.pkl', 'rb') as f:
                    raw = f.read(40)
                print(raw)
            else:
                self._books = []
                print("Файл с книгами не найден, создан новый список")
        except Exception as e:
            print(f"Ошибка при загрузке книг: {e}")
            self._books = []
        
        try:
            if os.path.exists('library_users.pkl'):
                with open('library_users.pkl', 'rb') as f:
                    self._users = pickle.load(f)
                print(f"пользователи успешно загружены")
                with open('library_users.pkl', 'rb') as f:
                    raw = f.read(40)
                print(raw)
                for p in self._users:
                    print(p)
            else:
                self._users = []
                print("Файл с пользователями не найден, создан новый список")
        except Exception as e:
            print(f"Ошибка при загрузке пользователей: {e}")
            self._users = []


    def find_book(self, title):
        for book in self._books:
            if book.name_book == title:
                return book
        return None

    def find_user(self, username):
        for user in self._users:
            if user.username == username:
                return user
        return None

    def get_book(self, title, username):
        book = self.find_book(title)
        user = self.find_user(username)

        if not book:
            print(f"Книга '{title}' не найдена")
            return False

        if not user:
            print(f"Пользователь '{username}' не найден")
            return False

        if not book.is_available:
            print(f"Книга '{title}' уже занята")
            return False

        book.is_available = False
        book.borrowed_by = username
        user.borrowed_books.append(title)
        self._save_data()
        print(f"Книга '{title}' выдана пользователю {username}")
        return True

    def return_book(self, title, username):
        book = self.find_book(title)
        user = self.find_user(username)

        if not book:
            print(f"Книга '{title}' не найдена")
            return False

        if not user:
            print(f"Пользователь '{username}' не найден")
            return False

        if title not in user.borrowed_books:
            print(f"Пользователь {username} не брал эту книгу")
            return False

        book.is_available = True
        book.borrowed_by = None
        user.borrowed_books.remove(title)
        self._save_data()
        print(f"Книга '{title}' возвращена")
        return True

    def add_book(self, name_book, author):
        book = Book(name_book, author)
        self._books.append(book)
        self._save_data()
        print(f"Книга '{name_book}' добавлена")
        return True

    def delete_book(self, name_book):
        for book in self._books:
            if book.name_book == name_book:
                if book.is_available:
                    self._books.remove(book)
                    self._save_data()
                    print(f"Книга '{name_book}' удалена")
                    return True
                else:
                    print(f"Книга '{name_book}' занята, нельзя удалить")
                    return False

        print(f"Книга '{name_book}' не найдена")
        return False

    def reg_user(self, username): 
        if not any(user.username == username for user in self._users):
            user = User(username)
            self._users.append(user)
            self._save_data()
            print(f"Пользователь '{username}' зарегистрирован")
            return True
        else:
            print("Пользователь уже зарегистрирован")
            return False


    def list_users(self):
        if not self._users:
            print("Нет зарегистрированных пользователей")
            return

        print("Список пользователей библиотеки:")
        for user in self._users:
            print(f"- {user.username}")

    def view_all_books(self):
        if not self._books:
            print("В библиотеке пока нет книг")
            return

        print("\nСписок всех книг:")
        for i, book in enumerate(self._books, 1):
            status = "доступна" if book.is_available else f"занята ({book.borrowed_by})"
            print(f"{i:3}. '{book.name_book}' - {book.author} ({status})")

class Librarian(Person):
    def menu(self, library):
        while True:
            print(f"\nМеню библиотекаря")
            print("1. Добавить книгу")
            print("2. Удалить книгу")
            print("3. Зарегистрировать пользователя")
            print("4. Просмотреть всех пользователей")
            print("5. Просмотреть все книги")
            print("6. Выйти")

            choice = input("Выберите действие: ")
            if choice == '1':
                title = input("Название книги: ")
                author = input("Автор: ")
                library.add_book(title, author)

            elif choice == '2':
                title = input("Название книги для удаления: ")
                library.delete_book(title)

            elif choice == '3':
                username = input("Имя пользователя: ")
                library.reg_user(username)

            elif choice == '4':
                library.list_users()

            elif choice == '5':
                library.view_all_books()

            elif choice == '6':
                break
            else:
                print("Неверный выбор")


def main():
    library = Library()

    while True:
        print("\nБиблиотека")
        print("1. Библиотекарь")
        print("2. Пользователь")
        print("3. Выйти")
        role = input("Выберите роль (1-3): ")
        
        if role == '1':
            librarian = Librarian("Библиотекарь")
            librarian.menu(library)

        elif role == '2':
            username = input("Ваше имя: ")
            user = User(username)
            user.menu(library)

        else:
            print("\nДо свидания")
            break


if __name__ == "__main__":
    main()

