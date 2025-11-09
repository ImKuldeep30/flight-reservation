const pool = require('../config/db');

function genReference() {
  const t = Date.now().toString(36).toUpperCase();
  const r = Math.random().toString(36).substring(2, 8).toUpperCase();
  return `BR${t}${r}`;
}

exports.createBooking = async (user_id, flight_id, passengers) => {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    const bookingRef = genReference();
    const [bRes] = await conn.execute(
      'INSERT INTO bookings (user_id, flight_id, booking_reference) VALUES (?, ?, ?)',
      [user_id, flight_id, bookingRef]
    );

    const bookingId = bRes.insertId;

    for (const p of passengers) {
      await conn.execute(
        'INSERT INTO booking_passengers (booking_id, name, age, gender, seat_id) VALUES (?, ?, ?, ?, ?)',
        [bookingId, p.name, p.age || null, p.gender || null, p.seat_id || null]
      );
    }

    await conn.commit();
    return { booking_id: bookingId, booking_reference: bookingRef };
  } catch (err) {
    await conn.rollback();
    throw err;
  } finally {
    conn.release();
  }
};

exports.cancelBooking = async (user_id, booking_id) => {
  // Only allow owner (or later: admin) to cancel
  const [rows] = await pool.execute('SELECT * FROM bookings WHERE booking_id = ?', [booking_id]);
  const booking = rows[0];
  if (!booking) throw new Error('Booking not found');
  if (booking.user_id !== user_id) throw new Error('Not authorized to cancel this booking');

  await pool.execute('UPDATE bookings SET status = ? WHERE booking_id = ?', ['cancelled', booking_id]);
  return true;
};
