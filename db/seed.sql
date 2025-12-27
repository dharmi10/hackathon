-- SEED DATA for GearGuard Maintenance Tracker

-- 1. INSERT DEPARTMENTS
INSERT INTO departments (name, description) VALUES
('Production', 'Manufacturing and production floor'),
('IT', 'Information Technology department'),
('Logistics', 'Warehouse and logistics operations'),
('Administration', 'Administrative offices'),
('Quality Control', 'Quality assurance and testing');

-- 2. INSERT USERS (Password: 'password123')
-- Note: In production, use bcrypt to hash passwords properly
INSERT INTO users (username, email, full_name, password_hash, role, department_id) VALUES
-- Admins
('admin', 'admin@gearguard.com', 'System Administrator', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'admin', 
 (SELECT id FROM departments WHERE name = 'IT' LIMIT 1)),

-- Managers
('john.manager', 'john.manager@gearguard.com', 'John Manager', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'manager',
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1)),
 
('sarah.lead', 'sarah.lead@gearguard.com', 'Sarah Lead', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'manager',
 (SELECT id FROM departments WHERE name = 'IT' LIMIT 1)),

-- Technicians
('mike.tech', 'mike.tech@gearguard.com', 'Mike Thompson', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'technician',
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1)),
 
('lisa.mech', 'lisa.mech@gearguard.com', 'Lisa Mechanical', '$2b$10$rKj5xKxGxKxGxKxGxO', 'technician',
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1)),
 
('david.elec', 'david.elec@gearguard.com', 'David Electrician', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'technician',
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1)),
 
('anna.it', 'anna.it@gearguard.com', 'Anna IT Support', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'technician',
 (SELECT id FROM departments WHERE name = 'IT' LIMIT 1)),

-- Regular Users
('robert.user', 'robert.user@gearguard.com', 'Robert Johnson', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'user',
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1)),
 
('emily.user', 'emily.user@gearguard.com', 'Emily Davis', '$2b$10$rKj5xKxGxKxGxKxGxO', 'user',
 (SELECT id FROM departments WHERE name = 'Administration' LIMIT 1)),
 
('carlos.user', 'carlos.user@gearguard.com', 'Carlos Martinez', '$2b$10$rKj5xKxGxKxGxKxGxKxGxO', 'user',
 (SELECT id FROM departments WHERE name = 'Logistics' LIMIT 1));

-- 3. INSERT MAINTENANCE TEAMS
INSERT INTO maintenance_teams (team_name, description, specialization) VALUES
('Mechanical Team', 'Handles all mechanical equipment repairs', 'Mechanics'),
('Electrical Team', 'Electrical systems and power equipment', 'Electricians'),
('IT Support Team', 'Computer hardware and software support', 'IT Support'),
('General Maintenance', 'General facility maintenance', 'General');

-- 4. INSERT TEAM MEMBERS
INSERT INTO team_members (team_id, user_id, is_team_lead) VALUES
-- Mechanical Team
((SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1), 
 (SELECT id FROM users WHERE username = 'mike.tech' LIMIT 1), true),
((SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1), 
 (SELECT id FROM users WHERE username = 'lisa.mech' LIMIT 1), false),

-- Electrical Team
((SELECT id FROM maintenance_teams WHERE team_name = 'Electrical Team' LIMIT 1), 
 (SELECT id FROM users WHERE username = 'david.elec' LIMIT 1), true),

-- IT Support Team
((SELECT id FROM maintenance_teams WHERE team_name = 'IT Support Team' LIMIT 1), 
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1), true);

-- 5. INSERT EQUIPMENT CATEGORIES
INSERT INTO equipment_categories (category_name, description) VALUES
('CNC Machines', 'Computer numerical control machines'),
('Laptops', 'Portable computers'),
('Desktop Computers', 'Desktop workstations'),
('Printers', 'Printing equipment'),
('Forklifts', 'Material handling equipment'),
('Conveyor Systems', 'Automated material transport'),
('Industrial Robots', 'Automated manufacturing robots'),
('Servers', 'Network and application servers');

-- 6. INSERT EQUIPMENT
INSERT INTO equipment (equipment_name, serial_number, category_id, department_id, maintenance_team_id, default_technician_id, purchase_date, warranty_expiry_date, location, status) VALUES
-- Production Equipment
('CNC Machine Alpha', 'CNC-2023-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'CNC Machines' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'mike.tech' LIMIT 1),
 '2023-01-15', '2026-01-15', 'Production Floor - Bay 1', 'active'),

('CNC Machine Beta', 'CNC-2023-002', 
 (SELECT id FROM equipment_categories WHERE category_name = 'CNC Machines' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'lisa.mech' LIMIT 1),
 '2023-03-20', '2026-03-20', 'Production Floor - Bay 2', 'active'),

('Industrial Robot ARM-1', 'ROBOT-2022-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Industrial Robots' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Production' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'Electrical Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'david.elec' LIMIT 1),
 '2022-06-10', '2025-06-10', 'Assembly Line 3', 'active'),

-- IT Equipment
('Printer HP LaserJet Pro', 'PRINT-2024-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Printers' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Administration' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'IT Support Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 '2024-02-01', '2027-02-01', 'Admin Office - Floor 2', 'active'),

('Network Server PROD-01', 'SRV-2022-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Servers' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'IT' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'IT Support Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 '2022-11-15', '2025-11-15', 'Server Room A', 'active'),

-- Personal Equipment (Assigned to Users)
('Laptop Dell XPS 15', 'LAPTOP-2024-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Laptops' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'IT' LIMIT 1),
 (SELECT id FROM users WHERE username = 'sarah.lead' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'IT Support Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 '2024-01-10', '2027-01-10', 'Office 201', 'active'),

('Laptop Lenovo ThinkPad', 'LAPTOP-2023-005', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Laptops' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Administration' LIMIT 1),
 (SELECT id FROM users WHERE username = 'emily.user' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'IT Support Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 '2023-09-20', '2026-09-20', 'Office 305', 'active'),

-- Logistics Equipment
('Forklift Toyota 8FBN25', 'FORK-2020-001', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Forklifts' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Logistics' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'lisa.mech' LIMIT 1),
 '2020-05-12', '2023-05-12', 'Warehouse Bay 5', 'active'),

('Forklift Crown FC5200', 'FORK-2021-002', 
 (SELECT id FROM equipment_categories WHERE category_name = 'Forklifts' LIMIT 1),
 (SELECT id FROM departments WHERE name = 'Logistics' LIMIT 1),
 (SELECT id FROM maintenance_teams WHERE team_name = 'Mechanical Team' LIMIT 1),
 (SELECT id FROM users WHERE username = 'mike.tech' LIMIT 1),
 '2021-07-18', '2024-07-18', 'Warehouse Bay 7', 'active');

-- 7. INSERT REQUEST STAGES
INSERT INTO request_stages (stage_name, stage_order, color_code, is_closed) VALUES
('New', 1, '#3B82F6', false),
('In Progress', 2, '#F59E0B', false),
('Repaired', 3, '#10B981', true),
('Scrap', 4, '#EF4444', true);

-- 8. INSERT SAMPLE MAINTENANCE REQUESTS
INSERT INTO maintenance_requests (subject, description, request_type, equipment_id, requested_by_user_id, assigned_to_user_id, stage_id, priority, scheduled_date) VALUES
-- Active Requests
('CNC Machine oil leak', 'Machine is leaking hydraulic oil from the main cylinder', 'corrective',
 (SELECT id FROM equipment WHERE serial_number = 'CNC-2023-001' LIMIT 1),
 (SELECT id FROM users WHERE username = 'robert.user' LIMIT 1),
 (SELECT id FROM users WHERE username = 'mike.tech' LIMIT 1),
 (SELECT id FROM request_stages WHERE stage_name = 'In Progress' LIMIT 1),
 'high', NULL),

('Laptop screen flickering', 'Screen flickers randomly during use', 'corrective',
 (SELECT id FROM equipment WHERE serial_number = 'LAPTOP-2023-005' LIMIT 1),
 (SELECT id FROM users WHERE username = 'emily.user' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 (SELECT id FROM request_stages WHERE stage_name = 'New' LIMIT 1),
 'medium', NULL),

('Routine maintenance - Forklift', 'Scheduled quarterly maintenance check', 'preventive',
 (SELECT id FROM equipment WHERE serial_number = 'FORK-2020-001' LIMIT 1),
 (SELECT id FROM users WHERE username = 'john.manager' LIMIT 1),
 (SELECT id FROM users WHERE username = 'lisa.mech' LIMIT 1),
 (SELECT id FROM request_stages WHERE stage_name = 'New' LIMIT 1),
 'medium', CURRENT_DATE + INTERVAL '3 days'),

('Server backup failure', 'Automated backup job failed last night', 'corrective',
 (SELECT id FROM equipment WHERE serial_number = 'SRV-2022-001' LIMIT 1),
 (SELECT id FROM users WHERE username = 'sarah.lead' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 (SELECT id FROM request_stages WHERE stage_name = 'In Progress' LIMIT 1),
 'critical', NULL),

-- Completed Request
('Printer paper jam fixed', 'Fixed recurring paper jam issue', 'corrective',
 (SELECT id FROM equipment WHERE serial_number = 'PRINT-2024-001' LIMIT 1),
 (SELECT id FROM users WHERE username = 'emily.user' LIMIT 1),
 (SELECT id FROM users WHERE username = 'anna.it' LIMIT 1),
 (SELECT id FROM request_stages WHERE stage_name = 'Repaired' LIMIT 1),
 'medium', NULL);

-- Display summary
DO $$
DECLARE
    dept_count INTEGER;
    user_count INTEGER;
    team_count INTEGER;
    cat_count INTEGER;
    equip_count INTEGER;
    stage_count INTEGER;
    req_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO dept_count FROM departments;
    SELECT COUNT(*) INTO user_count FROM users;
    SELECT COUNT(*) INTO team_count FROM maintenance_teams;
    SELECT COUNT(*) INTO cat_count FROM equipment_categories;
    SELECT COUNT(*) INTO equip_count FROM equipment;
    SELECT COUNT(*) INTO stage_count FROM request_stages;
    SELECT COUNT(*) INTO req_count FROM maintenance_requests;
    
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Database seeded successfully!';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Departments:          %', dept_count;
    RAISE NOTICE 'Users:                %', user_count;
    RAISE NOTICE 'Maintenance Teams:    %', team_count;
    RAISE NOTICE 'Equipment Categories: %', cat_count;
    RAISE NOTICE 'Equipment:            %', equip_count;
    RAISE NOTICE 'Request Stages:       %', stage_count;
    RAISE NOTICE 'Maintenance Requests: %', req_count;
    RAISE NOTICE '========================================';
END $$;