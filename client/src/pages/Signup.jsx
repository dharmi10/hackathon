import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Wrench, Mail, Lock, User, Briefcase } from 'lucide-react';
import bgImage from '../assets/bg-maintanence.jpg'; 

const Signup = () => {
  const [formData, setFormData] = useState({ name: '', email: '', password: '', role: 'Employee' });

  const handleChange = (e) => setFormData({ ...formData, [e.target.name]: e.target.value });

  return (
    <div 
      className="min-h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat p-4 font-sans relative"
      style={{ backgroundImage: `url(${bgImage})` }}
    >
      <div className="absolute inset-0 bg-black/60"></div>

      <div className="relative z-10 w-full max-w-5xl bg-white/10 backdrop-blur-2xl border border-white/20 rounded-[2.5rem] shadow-2xl overflow-hidden flex flex-col md:flex-row">
        
        <div className="md:w-5/12 p-12 flex flex-col justify-center text-white border-b md:border-b-0 md:border-r border-white/10 bg-blue-600/10">
          <div className="flex items-center gap-3 mb-8">
            <div className="bg-blue-600 p-2 rounded-xl shadow-lg">
              <Wrench className="w-8 h-8 text-white" />
            </div>
            <h1 className="text-4xl font-black tracking-tighter uppercase">GEARGUARD</h1>
          </div>
          <h2 className="text-2xl font-bold mb-4 text-blue-300 uppercase tracking-widest leading-tight">Join the Guard</h2>
          <p className="text-lg text-slate-200 font-light leading-relaxed">
            Create an account to track equipment and manage repair workflows efficiently.
          </p>
        </div>

        <div className="md:w-7/12 p-12 bg-white/5 flex flex-col justify-center">
          <form className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="md:col-span-2">
              <label className="block text-xs font-bold text-slate-400 uppercase mb-2 text-left">Full Name</label>
              <div className="relative">
                <User className="absolute left-4 top-3.5 h-5 w-5 text-slate-400" />
                <input type="text" name="name" placeholder="John Doe" className="w-full pl-12 pr-4 py-3.5 bg-white/10 border border-white/20 rounded-2xl text-white outline-none focus:ring-2 focus:ring-blue-500" onChange={handleChange} />
              </div>
            </div>

            <div className="md:col-span-1">
              <label className="block text-xs font-bold text-slate-400 uppercase mb-2 text-left">Work Email</label>
              <div className="relative">
                <Mail className="absolute left-4 top-3.5 h-5 w-5 text-slate-400" />
                <input type="email" name="email" placeholder="admin@gearguard.com" className="w-full pl-12 pr-4 py-3.5 bg-white/10 border border-white/20 rounded-2xl text-white outline-none focus:ring-2 focus:ring-blue-500" onChange={handleChange} />
              </div>
            </div>

            <div className="md:col-span-1">
              <label className="block text-xs font-bold text-slate-400 uppercase mb-2 text-left">Role</label>
              <div className="relative">
                <Briefcase className="absolute left-4 top-3.5 h-5 w-5 text-slate-400" />
                <select name="role" className="w-full pl-12 pr-4 py-3.5 bg-white/10 border border-white/20 rounded-2xl text-white outline-none focus:ring-2 focus:ring-blue-500 appearance-none transition-all cursor-pointer" onChange={handleChange}>
                  <option className="bg-slate-900" value="Employee">Employee</option>
                  <option className="bg-slate-900" value="Maintenance">Maintenance Team</option>
                  <option className="bg-slate-900" value="Admin">Admin</option>
                </select>
              </div>
            </div>

            <div className="md:col-span-2">
              <label className="block text-xs font-bold text-slate-400 uppercase mb-2 text-left">Password</label>
              <div className="relative">
                <Lock className="absolute left-4 top-3.5 h-5 w-5 text-slate-400" />
                <input type="password" name="password" placeholder="••••••••••••" className="w-full pl-12 pr-4 py-3.5 bg-white/10 border border-white/20 rounded-2xl text-white outline-none focus:ring-2 focus:ring-blue-500" onChange={handleChange} />
              </div>
            </div>

            <div className="md:col-span-2 pt-2">
              <button className="w-full bg-blue-600 hover:bg-blue-500 text-white font-black py-4 rounded-2xl transition-all shadow-xl active:scale-95 uppercase tracking-widest">
                Register Account
              </button>
            </div>
          </form>

          <p className="mt-8 text-center text-slate-400 text-sm">
            Already registered?{' '}
            <Link to="/login" className="text-blue-400 font-black hover:text-blue-300 transition-colors uppercase tracking-widest">Sign In</Link>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Signup;