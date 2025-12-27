import React from 'react';

const Login = () => {
  return (
    <div className="max-w-md mx-auto mt-12 bg-white p-8 rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6 text-center">Technician Login</h2>
      <form className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700">Email</label>
          <input type="email" className="mt-1 w-full p-2 border rounded-md focus:ring-blue-500" placeholder="technician@gearguard.com" />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700">Password</label>
          <input type="password" className="mt-1 w-full p-2 border rounded-md" />
        </div>
        <button className="w-full bg-slate-900 text-white py-2 rounded-md hover:bg-slate-800">Sign In</button>
      </form>
    </div>
  );
};

export default Login;