import React, { useEffect, useState } from "react";
import axiosInstance from "../../api/axiosInstance"; // ✅ correct path
import { useNavigate } from "react-router-dom";

const AvailableFlights = () => {
  const [flights, setFlights] = useState([]);
  const [filteredFlights, setFilteredFlights] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [user, setUser] = useState(JSON.parse(localStorage.getItem("user")) || null);
  // react-router navigate hook
  const navigate = useNavigate();

  // 🔍 Filter states
  const [search, setSearch] = useState("");
  const [minFare, setMinFare] = useState("");
  const [maxFare, setMaxFare] = useState("");

  const fetchFlights = async () => {
    try {
      setLoading(true);
      const res = await axiosInstance.get("/flights/upcoming");
      if (res.data.status && Array.isArray(res.data.flights)) {
        setFlights(res.data.flights);
        setFilteredFlights(res.data.flights);
      } else {
        setFlights([]);
        setFilteredFlights([]);
      }
    } catch (err) {
      console.error("Error fetching flights:", err);
      setError("Failed to load flights");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchFlights();
  }, []);

  // 🔍 Filter flights when search or fare changes
  const handleFilter = () => {
    let filtered = flights;

    if (search.trim() !== "") {
      filtered = filtered.filter((f) =>
        f.flight_number.toLowerCase().includes(search.toLowerCase())
      );
    }

    if (minFare) {
      filtered = filtered.filter(
        (f) => Number(f.base_fare) >= Number(minFare)
      );
    }

    if (maxFare) {
      filtered = filtered.filter(
        (f) => Number(f.base_fare) <= Number(maxFare)
      );
    }

    setFilteredFlights(filtered);
  };

  // ✈️ Date formatter
  const formatDate = (dateStr) =>
    new Date(dateStr).toLocaleString("en-GB", {
      day: "numeric",
      month: "short",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
      hour12: true,
    });

  if (loading) {
    return <p className="text-center text-gray-500 mt-8 text-lg">Loading flights...</p>;
  }

  if (error) {
    return <p className="text-center text-red-500 mt-8 text-lg">{error}</p>;
  }

  return (
    <div className="p-8 min-h-screen bg-gray-50">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-800">✈️ Available Flights</h1>
        {user.role === "admin" && (
          <button
            onClick={() => navigate("/admin/dashboard")}
            className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition"
          >
            Go to Admin Panel
          </button>
        )}
      </div>

      {/* 🔍 Search & Filter Bar */}
      <div className="flex flex-wrap gap-3 mb-8 bg-white shadow-md p-4 rounded-xl">
        <input
          type="text"
          placeholder="🔎 Search by flight number or airline"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="border border-gray-300 p-2 rounded-md flex-1 min-w-[200px]"
        />
        <input
          type="number"
          placeholder="Min Fare ₹"
          value={minFare}
          onChange={(e) => setMinFare(e.target.value)}
          className="border border-gray-300 p-2 rounded-md w-32"
        />
        <input
          type="number"
          placeholder="Max Fare ₹"
          value={maxFare}
          onChange={(e) => setMaxFare(e.target.value)}
          className="border border-gray-300 p-2 rounded-md w-32"
        />
        <button
          onClick={handleFilter}
          className="bg-blue-600 text-white px-5 py-2 rounded-md hover:bg-blue-700"
        >
          Apply
        </button>
      </div>

      {/* 🧾 Flights Display */}
      {filteredFlights.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {filteredFlights.map((f) => (
            <div
              key={f.flight_id}
              className="border rounded-xl p-5 bg-white shadow-sm hover:shadow-lg transition text-black"
            >
              <h2 className="text-xl font-semibold mb-1">
                Flight {f.flight_number}
              </h2>
              <p className="text-gray-700">
                <strong>Aircraft ID:</strong> {f.aircraft_id}
              </p>
              <p className="text-gray-700">
                <strong>From:</strong> {f.departure_airport_id} →{" "}
                <strong>To:</strong> {f.arrival_airport_id}
              </p>
              <p className="text-gray-700">
                <strong>Departure:</strong> {formatDate(f.departure_time)}
              </p>
              <p className="text-gray-700">
                <strong>Arrival:</strong> {formatDate(f.arrival_time)}
              </p>
              <p className="text-green-600 font-semibold mt-2 text-lg">
                ₹{Number(f.base_fare).toFixed(2)}
              </p>

              {/* 🟢 Book Button */}
              <button
                onClick={() => alert(`Booking flight ${f.flight_number}...`)}
                className="mt-3 bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 w-full"
              >
                Book Flight
              </button>
            </div>
          ))}
        </div>
      ) : (
        <p className="text-center text-gray-500 mt-6">
          No flights found. Try changing filters.
        </p>
      )}
    </div>
  );
};

export default AvailableFlights;
