// src/components/admin/FlightTable.jsx
import React from "react";

const FlightTable = ({ flights, onEdit, onDelete }) => {
  if (!flights.length)
    return (
      <p className="text-center text-gray-500 mt-8">No flights available.</p>
    );

  return (
    <div className="overflow-x-auto bg-white shadow-md rounded-2xl">
      <table className="min-w-full text-sm text-left border-collapse">
        <thead className="bg-gray-100 text-gray-700 uppercase">
          <tr>
            <th className="p-3 border-b">#</th>
            <th className="p-3 border-b">Flight No.</th>
            <th className="p-3 border-b">From</th>
            <th className="p-3 border-b">To</th>
            <th className="p-3 border-b">Departure</th>
            <th className="p-3 border-b">Arrival</th>
            <th className="p-3 border-b">Fare (₹)</th>
            <th className="p-3 border-b text-center">Actions</th>
          </tr>
        </thead>

        <tbody>
          {flights.map((flight, index) => (
            <tr
              key={flight.flight_id}
              className="hover:bg-gray-50 border-b last:border-none text-gray-800 items-center"
            >
              <td className="p-3">{index + 1}</td>
              <td className="p-3 font-medium">{flight.flight_number}</td>
              <td className="p-3">{flight.departure_code}</td>
              <td className="p-3">{flight.arrival_code}</td>
              <td className="p-3 text-xs">
                {new Date(flight.departure_time).toLocaleString()}
              </td>
              <td className="p-3 text-xs">
                {new Date(flight.arrival_time).toLocaleString()}
              </td>
              <td className="p-3">{flight.base_fare}</td>
              <td className="p-3 text-center space-x-2">
                <button
                  onClick={() => onEdit(flight.flight_id)}
                  className="bg-blue-600 text-white px-3 py-1 rounded-md hover:bg-blue-700"
                >
                  Edit
                </button>
                <button
                  onClick={() => onDelete(flight.flight_id)}
                  className="bg-red-600 text-white px-3 py-1 rounded-md hover:bg-red-700"
                >
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default FlightTable;
