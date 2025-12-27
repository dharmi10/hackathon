-- GearGuard Maintenance Tracker Database Schema
-- PostgreSQL Database Setup

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS request_comments CASCADE;
DROP TABLE IF EXISTS request_history CASCADE;
DROP TABLE IF EXISTS maintenance_requests CASCADE;
DROP TABLE IF EXISTS request_stages CASCADE;
DROP TABLE IF EXISTS equipment CASCADE;
DROP TABLE IF EXISTS equipment_categories CASCADE;
DROP TABLE IF EXISTS team_members CASCADE;
DROP TABLE IF EXISTS maintenance_teams CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- 1. DEPARTMENTS TABLE
CREATE TABLE departments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. USERS TABLE (Employees/Technicians)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'manager', 'technician', 'user')),
    department_id UUID REFERENCES departments(id) ON DELETE SET NULL,
    avatar_url VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. MAINTENANCE TEAMS TABLE
CREATE TABLE maintenance_teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    specialization VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. TEAM MEMBERS (Junction Table)
CREATE TABLE team_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id UUID NOT NULL REFERENCES maintenance_teams(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    is_team_lead BOOLEAN DEFAULT false,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(team_id, user_id)
);

-- 5. EQUIPMENT CATEGORIES TABLE
CREATE TABLE equipment_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. EQUIPMENT TABLE
CREATE TABLE equipment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    equipment_name VARCHAR(150) NOT NULL,
    serial_number VARCHAR(100) UNIQUE NOT NULL,
    category_id UUID REFERENCES equipment_categories(id) ON DELETE SET NULL,
    department_id UUID REFERENCES departments(id) ON DELETE SET NULL,
    assigned_to_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    maintenance_team_id UUID REFERENCES maintenance_teams(id) ON DELETE SET NULL,
    default_technician_id UUID REFERENCES users(id) ON DELETE SET NULL,
    purchase_date DATE,
    warranty_expiry_date DATE,
    location VARCHAR(255),
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'maintenance', 'scrapped', 'retired')),
    is_scrapped BOOLEAN DEFAULT false,
    scrap_date TIMESTAMP,
    scrap_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. MAINTENANCE REQUEST STAGES
CREATE TABLE request_stages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    stage_name VARCHAR(50) NOT NULL UNIQUE,
    stage_order INTEGER NOT NULL UNIQUE,
    color_code VARCHAR(7),
    is_closed BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. MAINTENANCE REQUESTS TABLE
CREATE TABLE maintenance_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    request_number VARCHAR(50) UNIQUE NOT NULL DEFAULT 'REQ-TEMP',
    subject VARCHAR(255) NOT NULL,
    description TEXT,
    request_type VARCHAR(20) NOT NULL CHECK (request_type IN ('corrective', 'preventive')),
    equipment_id UUID NOT NULL REFERENCES equipment(id) ON DELETE RESTRICT,
    category_id UUID REFERENCES equipment_categories(id),
    maintenance_team_id UUID REFERENCES maintenance_teams(id),
    requested_by_user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    assigned_to_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    stage_id UUID NOT NULL REFERENCES request_stages(id),
    priority VARCHAR(20) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'critical')),
    scheduled_date TIMESTAMP,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    duration_hours DECIMAL(5,2),
    is_overdue BOOLEAN DEFAULT false,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. REQUEST COMMENTS/LOGS TABLE
CREATE TABLE request_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    request_id UUID NOT NULL REFERENCES maintenance_requests(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    comment TEXT NOT NULL,
    is_internal BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. REQUEST HISTORY (Audit Trail)
CREATE TABLE request_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    request_id UUID NOT NULL REFERENCES maintenance_requests(id) ON DELETE CASCADE,
    changed_by_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    field_changed VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    change_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INDEXES for Performance
CREATE INDEX idx_equipment_dept ON equipment(department_id);
CREATE INDEX idx_equipment_team ON equipment(maintenance_team_id);
CREATE INDEX idx_equipment_status ON equipment(status);
CREATE INDEX idx_requests_equipment ON maintenance_requests(equipment_id);
CREATE INDEX idx_requests_assigned ON maintenance_requests(assigned_to_user_id);
CREATE INDEX idx_requests_stage ON maintenance_requests(stage_id);
CREATE INDEX idx_requests_scheduled ON maintenance_requests(scheduled_date);
CREATE INDEX idx_requests_created ON maintenance_requests(created_at);
CREATE INDEX idx_team_members_user ON team_members(user_id);
CREATE INDEX idx_team_members_team ON team_members(team_id);

-- TRIGGER: Auto-generate request number
CREATE OR REPLACE FUNCTION generate_request_number()
RETURNS TRIGGER AS $$
DECLARE
    next_number INTEGER;
    year_str VARCHAR(4);
BEGIN
    year_str := TO_CHAR(CURRENT_DATE, 'YYYY');
    
    SELECT COALESCE(MAX(CAST(SUBSTRING(request_number FROM 10) AS INTEGER)), 0) + 1
    INTO next_number
    FROM maintenance_requests
    WHERE request_number LIKE 'REQ-' || year_str || '-%';
    
    NEW.request_number := 'REQ-' || year_str || '-' || LPAD(next_number::TEXT, 4, '0');
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_request_number 
BEFORE INSERT ON maintenance_requests
FOR EACH ROW 
EXECUTE FUNCTION generate_request_number();

-- TRIGGER: Auto-fill category and team from equipment
CREATE OR REPLACE FUNCTION auto_fill_request_from_equipment()
RETURNS TRIGGER AS $$
BEGIN
    SELECT category_id, maintenance_team_id
    INTO NEW.category_id, NEW.maintenance_team_id
    FROM equipment
    WHERE id = NEW.equipment_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_auto_fill_request 
BEFORE INSERT ON maintenance_requests
FOR EACH ROW 
EXECUTE FUNCTION auto_fill_request_from_equipment();

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'Schema created successfully!';
END $$;