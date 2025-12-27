import { Link } from 'react-router-dom';

const Navbar = () => {
  return (
    <nav className="bg-gray-900 text-white shadow-lg">
      <div className="container mx-auto px-6 py-4 flex justify-between items-center">
        <Link to="/" className="text-2xl font-bold tracking-tighter">
          GEAR<span className="text-blue-500">GUARD</span>
        </Link>
        <div className="space-x-8 font-medium">
          <Link to="/kanban" className="hover:text-blue-400 transition">Kanban Board</Link>
          <Link to="/equipment" className="hover:text-blue-400 transition">Equipment</Link>
          <Link to="/calendar" className="hover:text-blue-400 transition">Calendar</Link>
          <Link to="/login" className="bg-blue-600 px-4 py-2 rounded hover:bg-blue-700 transition">Login</Link>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;