import socket
import threading

lock = threading.Lock()
clients = {}

def broadcast(message, sender_socket=None):
    with lock:
        for c in clients:
            if c != sender_socket:
                try:
                    c.send(message.encode('utf-8'))
                except:
                    if c in clients:
                        del clients[c]

def client_thread(client_socket, client_addr):
    print(f" Клиент {client_addr} подключился")
    
    try:
        name = client_socket.recv(1024).decode('utf-8').strip()
        with lock:
            clients[client_socket]=name
        
        client_socket.send(f"Добро пожаловать в чат".encode('utf-8'))
        broadcast(f" {name} присоединился к чату", client_socket)
        
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            msg = data.decode('utf-8')
            print(f"{name}: {msg}")
            broadcast(f"{name}: {msg}", client_socket)
    except:
        pass
    finally:
        with lock:
            if client_socket in clients:
                del clients[client_socket]
        broadcast(f" {name} покинул чат")
        client_socket.close()
        print(f" Клиент {name} отключился")

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('127.0.0.1', 5002))
server.listen()

print(" Сервер запущен на 127.0.0.1:5002")
print(" Ожидание подключений...")

while True:
    try:
        client_sock, client_addr = server.accept()
        thread = threading.Thread(target=client_thread, args=(client_sock, client_addr))
        
        thread.daemon = True
        thread.start()
        print(f" Активных клиентов: {len(clients)}")
    except KeyboardInterrupt:
        print("\n Сервер остановлен")
        break