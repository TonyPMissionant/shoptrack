import productsRouter from './routes/products.js';
import express from 'express';
import { pool, checkDatabaseConnection } from './db.js';
import ordersRouter from './routes/orders.js';

const app = express();
const port = 3000;

app.use(express.json());

app.use('/products', productsRouter);

app.use('/orders', ordersRouter);

app.get('/health', async (_req, res) => {
  try {
    await pool.query('SELECT 1');
    res.status(200).json({
      status: 'ok',
      database: 'connected',
    });
  } catch (error) {
    console.error('Health check failed:', error);
    res.status(503).json({
      status: 'error',
      database: 'disconnected',
    });
  }
});

async function startServer(): Promise<void> {
  await checkDatabaseConnection();

  app.listen(port, () => {
    console.log(`ShopTrack API running at http://localhost:${port}`);
  });
}

startServer().catch((error: unknown) => {
  console.error('Failed to start ShopTrack API:', error);
  process.exit(1);
});
