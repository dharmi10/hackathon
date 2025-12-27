const EquipmentList = () => {
  return (
    <div className="bg-white p-6 rounded-lg shadow">
      <h2 className="text-2xl font-bold mb-4">Company Equipment</h2>
      <p className="text-gray-600 mb-4">Tracking ownership, serial numbers, and warranty[cite: 9, 16, 17].</p>
      {/* Table goes here */}
      <div className="border-2 border-dashed border-gray-200 h-64 flex items-center justify-center text-gray-400">
        Equipment List Table (Fetching from /api/listings)
      </div>
    </div>
  );
};

export default EquipmentList;