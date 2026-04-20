import socket
import threading

def receive_messages(sock):
    while True:
        try:
            data = sock.recv(1024)
            if not data:
                print("\n Соединение с сервером разорвано")
                break
            print(f"\n{data.decode('utf-8')}")
            print("> ", end="", flush=True)
        except:
            print("\n Ошибка приема сообщений")
            break

def send_messages(sock):
    while True:
        msg = input("> ")
        if msg.lower() == '/quit':
            print(" Отключение...")
            sock.close()
            break
        if msg.strip():
            try:
                sock.send(msg.encode('utf-8'))
            except:
                break

try:
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(('127.0.0.1', 5002))
    name = input("введите ваше имя: ")
    if not name: name = "гость"
    client.send(name.encode('utf-8'))
    print("\n Подключение к чату")
    
    receive_thread = threading.Thread(target=receive_messages, args=(client,))
    send_thread = threading.Thread(target=send_messages, args=(client,))
    
    receive_thread.daemon = True
    send_thread.daemon = True
    
    receive_thread.start()
    send_thread.start()
    
    send_thread.join()
    
except ConnectionRefusedError:
    print("\n Не удалось подключиться к серверу")