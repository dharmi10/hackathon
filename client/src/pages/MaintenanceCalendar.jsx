import React, { useState } from 'react';
// Note: You may need to run 'npm install react-calendar'
import Calendar from 'react-calendar';
import 'react-calendar/dist/Calendar.css';

const MaintenanceCalendar = () => {
  const [date, setDate] = useState(new Date());

  // In a real app, you would filter your 'Preventive' requests by date
  return (
    <div className="bg-white p-8 rounded-xl shadow-lg">
      <h2 className="text-2xl font-bold text-gray-800 mb-6">Maintenance Schedule</h2>
      <div className="flex flex-col md:flex-row gap-8">
        <div className="flex-1">
          <Calendar 
            onChange={setDate} 
            value={date} 
            className="rounded-lg border-none shadow-sm"
          />
        </div>
        <div className="flex-1 bg-gray-50 p-6 rounded-lg border border-gray-200">
          <h3 className="font-semibold text-lg mb-4">
            Schedule for {date.toDateString()}
          </h3>
          <div className="space-y-4">
            <p className="text-gray-500 italic">No Preventive maintenance scheduled for this date.</p>
            <button className="w-full py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition">
              + Schedule New Checkup
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MaintenanceCalendar;