// db.js
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: 'postgres', // or your username
  host: 'localhost',
  database: 'gearguard',
  password: 'devanshi1912', // Replace with your actual password
  port: 5432,
});

module.exports = pool;