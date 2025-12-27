import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';

// Component Imports (You will create these files in your pages folder)
import Navbar from './components/Navbar';
import Dashboard from './pages/Dashboard';
import EquipmentList from './pages/EquipmentList';
import KanbanBoard from './pages/KanbanBoard';
import MaintenanceCalendar from './pages/MaintenanceCalendar';
import Login from './pages/Login';
import Register from './pages/Register';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50 text-gray-900 font-sans">
        {/* Toast notifications for "Repaired" or "Scrapped" alerts */}
        <Toaster position="top-center" />
        
        {/* Navigation Bar with Kanban, Equipment, and Calendar links */}
        <Navbar />
        
        <div className="container mx-auto px-4 py-6">
          <Routes>
            {/* The Technician Dashboard with the Red, Green, and Blue metric boxes */}
            <Route path="/" element={<Dashboard />} />
            <Route path="/dashboard" element={<Dashboard />} />

            {/* Equipment: Tracks Serial Numbers and Warranty Info [cite: 16, 17] */}
            <Route path="/equipment" element={<EquipmentList />} />

            {/* Kanban: Handles the lifecycle (New | In Progress | Repaired | Scrap) [cite: 55] */}
            <Route path="/kanban" element={<KanbanBoard />} />

            {/* Calendar: Specifically for Preventive maintenance tasks [cite: 62] */}
            <Route path="/calendar" element={<MaintenanceCalendar />} />

            {/* Auth Routes */}
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;