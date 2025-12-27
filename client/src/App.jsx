// src/App.jsx
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import Home from './pages/Home';
import Dashboard from './pages/Dashboard';
import Login from './pages/Login';
import Register from './pages/Register'; // <--- IMPORT THIS
import SellEnergy from './pages/SellEnergy';
import { Toaster } from 'react-hot-toast';
import Notifications from './pages/Notifications';
import AdminDashboard from './pages/AdminDashboard';
function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50 text-gray-900 font-sans">
        <Toaster position="top-center" />
        <Navbar />
        <div className="container mx-auto px-4 py-6">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/sell" element={<SellEnergy />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} /> {/* <--- ADD THIS */}
            <Route path="/notifications" element={<Notifications />} />
            <Route path="/admin" element={<AdminDashboard />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;