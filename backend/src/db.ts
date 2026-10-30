
import pg from 'pg';

const { Pool } = pg;

export const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'shoptrack',
  user: 'shoptrack_user',
  password: 'shoptrack_dev_password',
});

export async function checkDatabaseConnection(): Promise<void> {
  const result = await pool.query('SELECT NOW() AS current_time');
  console.log('Database connected:', result.rows[0].current_time);
}
