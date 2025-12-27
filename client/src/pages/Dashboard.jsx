import React, { useState, useEffect } from 'react';

const Dashboard = () => {
  // Stats would normally be fetched from your /api/dashboard/stats route
  const [stats, setStats] = useState({ scrap: 5, pending: 12, utilization: 78 });

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-gray-800">Technician Dashboard</h1>
      
      {/* Metric Boxes */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Red: Scrap Logic - Equipment no longer usable [cite: 74, 76] */}
        <div className="bg-red-600 text-white p-6 rounded-xl shadow-lg border-b-4 border-red-800">
          <h3 className="text-lg font-semibold uppercase tracking-wider">Scrap Assets</h3>
          <p className="text-5xl font-bold mt-2">{stats.scrap}</p>
          <p className="mt-4 text-sm opacity-80">Equipment marked as unusable</p>
        </div>

        {/* Green: Pending & Overdue - Requests in 'New' or 'In Progress' [cite: 55, 60] */}
        <div className="bg-green-600 text-white p-6 rounded-xl shadow-lg border-b-4 border-green-800">
          <h3 className="text-lg font-semibold uppercase tracking-wider">Pending & Overdue</h3>
          <p className="text-5xl font-bold mt-2">{stats.pending}</p>
          <p className="mt-4 text-sm opacity-80">Active maintenance requests</p>
        </div>

        {/* Blue: Workforce Utilization - Based on Hours Spent (Duration) [cite: 35, 45] */}
        <div className="bg-blue-600 text-white p-6 rounded-xl shadow-lg border-b-4 border-blue-800">
          <h3 className="text-lg font-semibold uppercase tracking-wider">Workforce Utilization</h3>
          <p className="text-5xl font-bold mt-2">{stats.utilization}%</p>
          <div className="w-full bg-blue-400 rounded-full h-2.5 mt-4">
            <div className="bg-white h-2.5 rounded-full" style={{ width: `${stats.utilization}%` }}></div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;