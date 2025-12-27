const KanbanBoard = () => {
  const stages = ['New', 'In Progress', 'Repaired', 'Scrap']; // [cite: 55]

  return (
    <div className="flex space-x-4 overflow-x-auto pb-4">
      {stages.map(stage => (
        <div key={stage} className="bg-gray-200 min-w-[300px] p-4 rounded-lg">
          <h3 className="font-bold text-gray-700 mb-4 uppercase">{stage}</h3>
          <div className="space-y-3">
            <div className="bg-white p-4 rounded shadow text-sm border-l-4 border-blue-500">
               Sample Request: Leaking Oil [cite: 31]
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default KanbanBoard;