const pool = require('../config/db');

exports.createPayment = async (booking_id, amount, method) => {
  const [res] = await pool.execute(
    'INSERT INTO payments (booking_id, amount, method) VALUES (?, ?, ?)',
    [booking_id, amount, method]
  );
  return { payment_id: res.insertId, booking_id, amount, method };
};
