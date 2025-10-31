-- ===== 01_user_status.sql =====
-- ========================================
-- TABLA AUXILIAR: user_status
-- ========================================

CREATE TABLE IF NOT EXISTS user_status (
    id SMALLINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Insert de valores base
INSERT INTO user_status (id, status_name)
VALUES
  (0, 'Inactivo'),
  (1, 'Activo'),
  (2, 'Suspendido'),
  (3, 'Desvinculado')
ON CONFLICT DO NOTHING;

-- ===== 02_users.sql =====
-- ========================================
-- TABLA PRINCIPAL: users
-- ========================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    profile VARCHAR(50),
    role VARCHAR(50),
    status_id SMALLINT DEFAULT 1 REFERENCES user_status(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert de usuarios de prueba
INSERT INTO users (username, name, email)
VALUES 
  ('admin', 'Administrador General', 'admin@app.com'),
  ('alex', 'Alex Zajarov', 'alex@app.com');

-- ===== 03_accounts.sql =====
-- 01_accounts.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accounts (name, type) VALUES
    ('Cliente A', 'Externo'),
    ('Cliente B', 'Externo'),
    ('Uso Interno', 'Interno');


-- ===== 04_project_status.sql =====
-- Tabla auxiliar de estados de proyectos
CREATE TABLE IF NOT EXISTS project_status (
    id SMALLINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Estados posibles para proyectos
INSERT INTO project_status (id, status_name)
VALUES
    (1, 'Activo'),
    (2, 'En espera'),
    (3, 'Suspendido'),
    (4, 'Finalizado'),
    (5, 'Cancelado')
ON CONFLICT DO NOTHING;

-- ===== 05_projects.sql =====
-- Tabla de proyectos vinculada a cuentas y estados
CREATE TABLE IF NOT EXISTS projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    account_id UUID REFERENCES accounts(id),
    status_id SMALLINT REFERENCES project_status(id) DEFAULT 1,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ⚠️ Los siguientes inserts requieren UUIDs reales de cuentas existentes
-- INSERT INTO projects (name, account_id, status_id, description)
-- VALUES
--   ('Implementación CRM', 'UUID_ACME', 1, 'Proyecto para cliente Acme'),
--   ('App Interna Timesheet', 'UUID_INTERNO', 2, 'Desarrollo de app interna');

-- ===== 06_timesheet_status.sql =====

-- 05_timesheet_status.sql
CREATE TABLE IF NOT EXISTS timesheet_status (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Inserts iniciales
INSERT INTO timesheet_status (id, name) VALUES
    (0, 'Draft'),
    (1, 'Submitted'),
    (2, 'Approved'),
    (3, 'Rejected'),
    (4, 'Billed')
ON CONFLICT DO NOTHING;


-- ===== 07_timesheet_header.sql =====

-- 06_timesheet_header.sql
CREATE TABLE IF NOT EXISTS timesheet_header (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    project_id UUID NOT NULL REFERENCES projects(id),
    work_date DATE NOT NULL,
    status_id SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ===== 08_timesheet_item.sql =====

-- 07_timesheet_item.sql
CREATE TABLE IF NOT EXISTS timesheet_item (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    header_id UUID NOT NULL REFERENCES timesheet_header(id),
    description TEXT NOT NULL,
    hours NUMERIC(5,2) NOT NULL CHECK (hours >= 0),
    billable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


