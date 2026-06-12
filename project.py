# project.py
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, Session, sessionmaker

engine = create_engine("sqlite:///library.db", echo=True)
print(engine)

Base = declarative_base()

class Author(Base):
    __tablename__ = 'authors'
    id = Column(Integer, primary_key=True) 
    name = Column(String(50), nullable=False)
    birth_year = Column(Integer, nullable=False)
    books = relationship('Book', back_populates='author')

class Book(Base):  
    __tablename__ = 'books'
    id = Column(Integer, primary_key=True)
    title = Column(String(50), nullable=False)
    year = Column(Integer, nullable=False)
    author_id = Column(Integer, ForeignKey('authors.id'))
    author = relationship('Author', back_populates='books')

Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session = Session()

authors_list = [
    Author(name='Федор Михайлович Достоевский', birth_year=1821),
    Author(name='Николай Васильевич Гоголь', birth_year=1809),
    Author(name='Лев Николаевич Толстой', birth_year=1821)
]
session.add_all(authors_list)
session.commit()

books_list = [
    Book(title='Война и мир', year=1867, author_id=3),
    Book(title='Преступление и наказание', year=1866, author_id=1),
    Book(title='Мертвые души', year=1842, author_id=2),
    Book(title='Ревизор', year=1836, author_id=2),
    Book(title='Белые ночи', year=1846, author_id=1)
]
session.add_all(books_list)
session.commit()

def select_auth():
    authors = session.query(Author).all()
    for author in authors:
        print(f"ID: {author.id}, имя: {author.name}, год рождения: {author.birth_year}")

def upd_auth(id, name):
    author = session.query(Author).get(id)
    author.name = name
    session.commit()
    if not author:
        print(f"Автор не найден")

def del_book(id):
    book = session.query(Book).get(id)
    session.delete(book)
    session.commit()
    if not book:
        print("книга не найдена")


def books_sorted_by_year():
    book = session.query(Book).order_by(Book.year.desc()).all()
    print("\nКниги, отсортированные по году:")
    print(f"ID: {book.id}, Название: {book.title}, Год: {book.year}")

def books_after1950():
    books = session.query(Book).filter(Book.year > 1950).all()
    print("\nКниги, изданные после 1950 года:")
    for book in books:
        print(f"ID: {book.id}, Название: {book.title}, Год: {book.year}")
    if not book:
        print("Нет книг, изданных после 1950 года")

def get_auth(name):
    author = session.query(Author).filter(Author.name == name).first()
    print(f"Имя: {author.name}, Год рождения: {author.birth_year}")
    books = session.query(Book).filter(Book.author_id == author.id).all()
    print("Его книги:")
    for book in books:
        print(f"  - {book.title} ({book.year})")
    if not author:
        print(f"Автор не найден")

def count_books():
    count = session.query(func.count(Book.id)).scalar()
    print(f"\nколичество книг в библиотеке: {count}")

def first_three_books_alphabetical():
    books = session.query(Book).order_by(Book.title).limit(3).all()
    for book in books:
        print(f"ID: {book.id}, Название: {book.title}, Год: {book.year}")

while True:
    print("""
    1. Вывести всех авторов
    2. Изменить автора
    3. Удалить книгу
    4. Книги, отсортированные по году (от новых к старым)
    5. Книги, изданные после 1950 года
    6. Автор по конкретному имени
    7. Количество книг
    8. Первые 3 книги в алфавитном порядке
    9. Выйти
    """)
    
    choice = input("введите цифру: ")
    match choice:
        case "1":
            select_auth()
        case "2":
            id = int(input("введите id автора: "))
            name = input("введите новое имя: ")
            upd_auth(id, name)
        case "3":
            id = int(input("введите id книги: "))
            del_book(id)
        case "4":
            books_sorted_by_year()
        case "5":
            books_after1950()
        case "6":
            name = input("введите имя для поиска: ")
            get_auth(name)
        case "7":
            count_books()
        case "8":
            first_three_books_alphabetical()
        case "9":
            print("Программа завершена")
            break
        case _:
            print("Неверный ввод. Пожалуйста, выберите цифру от 1 до 9")

session.close()