import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';

// Component Imports
import Navbar from './components/Navbar';
import Dashboard from './pages/Dashboard';
import EquipmentList from './pages/EquipmentList';
import KanbanBoard from './pages/KanbanBoard';
import MaintenanceCalendar from './pages/MaintenanceCalendar';
import Login from './pages/Login';
import Register from './pages/Register';
import Signup from './pages/Signup'; // New Import

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50 text-gray-900 font-sans">
        <Toaster position="top-center" />
        <Navbar />
        
        <div className="container mx-auto px-4 py-6">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/equipment" element={<EquipmentList />} />
            <Route path="/kanban" element={<KanbanBoard />} />
            <Route path="/calendar" element={<MaintenanceCalendar />} />
            
            {/* Auth Routes */}
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            {/* Added Signup Route to match your file structure */}
            <Route path="/signup" element={<Signup />} /> 
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;