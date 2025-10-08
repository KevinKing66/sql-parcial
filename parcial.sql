DROP TABLE IF EXISTS Reservas;
DROP TABLE IF EXISTS Clases;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Instructores;
DROP TABLE IF EXISTS Sedes;

CREATE TABLE Sedes (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE Instructores (
    id_instructor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(80),
    correo VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(120) UNIQUE NOT NULL,
    membresia ENUM('BASICA','PREMIUM') NOT NULL DEFAULT 'BASICA'
);

CREATE TABLE Clases (
    id_clase INT PRIMARY KEY AUTO_INCREMENT,
    id_sede INT NOT NULL,
    id_instructor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    cupo INT NOT NULL CHECK (cupo > 0),
    fecha_hora DATETIME NOT NULL,
    duracion_min INT NOT NULL CHECK (duracion_min > 0),
    FOREIGN KEY (id_sede) REFERENCES Sedes(id_sede),
    FOREIGN KEY (id_instructor) REFERENCES Instructores(id_instructor)
);

CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_clase INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('RESERVADA','CANCELADA','ASISTIDA') NOT NULL DEFAULT 'RESERVADA',
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_clase) REFERENCES Clases(id_clase),
    UNIQUE KEY uq_reserva_unica (id_cliente, id_clase) -- un cliente no puede reservar dos veces la misma clase
);

-- ------------------------------------------------------------
-- Inserción de datos mínimos de prueba 
-- ------------------------------------------------------------
INSERT INTO Sedes (nombre, direccion) VALUES
('Centro', 'Calle 10 #5-20'),
('Norte', 'Av. 3N #45-12'),
('Sur', 'Cra. 80 #30-55'),
('Occidente', 'Transv. 5 #72-10'),
('Oriente', 'Calle 50 #12-34');

INSERT INTO Instructores (nombre, especialidad, correo) VALUES
('Laura Díaz', 'Spinning', 'laura.diaz@gym.com'),
('Carlos Rojas', 'CrossFit', 'carlos.rojas@gym.com'),
('Andrea Méndez', 'Yoga', 'andrea.mendez@gym.com'),
('Diego Pardo', 'HIIT', 'diego.pardo@gym.com'),
('Sofía Martínez', 'Pilates', 'sofia.martinez@gym.com');

INSERT INTO Clientes (nombre, correo, membresia) VALUES
('Juan Pérez', 'juan.perez@correo.com', 'BASICA'),
('María López', 'maria.lopez@correo.com', 'PREMIUM'),
('Pedro Gómez', 'pedro.gomez@correo.com', 'BASICA'),
('Ana Torres', 'ana.torres@correo.com', 'PREMIUM'),
('Luis Fernández', 'luis.fernandez@correo.com', 'BASICA');

-- Clases próximas (fechas de ejemplo)
INSERT INTO Clases (id_sede, id_instructor, nombre, cupo, fecha_hora, duracion_min) VALUES
(1, 1, 'Spinning AM', 10, '2025-10-10 07:00:00', 60),
(2, 2, 'CrossFit Power', 12, '2025-10-10 18:00:00', 50),
(3, 3, 'Yoga Flow', 15, '2025-10-11 08:00:00', 70),
(4, 4, 'HIIT Express', 8,  '2025-10-11 19:00:00', 30),
(5, 5, 'Pilates Core', 10, '2025-10-12 06:30:00', 55);

-- Reservas iniciales
INSERT INTO Reservas (id_cliente, id_clase, estado) VALUES
(1, 1, 'RESERVADA'),
(2, 1, 'ASISTIDA'),
(3, 2, 'RESERVADA'),
(4, 3, 'RESERVADA'),
(5, 4, 'CANCELADA');
