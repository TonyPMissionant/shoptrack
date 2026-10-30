import { Router } from 'express';
import { pool } from '../db.js';

const router = Router();

router.post('/', async (req, res) => {
    try {
        const { customerId, items } = req.body;

        if (!Number.isInteger(customerId) || !Array.isArray(items) || items.length === 0) {
            return res.status(400).json({
                error: 'A valid customer ID and at least one order item are required',
            });
        }

        res.status(200).json({
            message: 'Order request received',
            customerId,
            items,
        });

    } catch (error) {
        console.error('Order creation failed:', error);

        res.status(500).json({
            error: 'Failed to process order',
        });
    }
});

export default router;
