import React from 'react';

const Register = () => {
  return (
    <div className="max-w-md mx-auto mt-12 bg-white p-8 rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6 text-center">Create Account</h2>
      <form className="space-y-4">
        <input type="text" placeholder="Full Name" className="w-full p-2 border rounded-md" />
        <input type="email" placeholder="Email Address" className="w-full p-2 border rounded-md" />
        <select className="w-full p-2 border rounded-md">
          <option>Select Team</option>
          <option>Mechanics</option>
          <option>Electricians</option>
          <option>IT Support</option>
        </select>
        <button className="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700">Register</button>
      </form>
    </div>
  );
};

export default Register;