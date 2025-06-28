// require('dotenv').config();
// const express = require('express');
// const cors = require('cors');
// const mysql = require('mysql2/promise');

import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import mysql from 'mysql2/promise';


const app = express();
const PORT = 3001;

// Database configuration
const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: 'nick@1234',
  database: 'scms_db'
};

// Middleware
app.use(cors({
  origin: 'http://localhost:5173',
  optionsSuccessStatus: 200
}));
app.use(express.json());

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ status: 'healthy' });
});

// API endpoint
app.get('/api/attendance', async (req, res) => {
  const { rollNumber } = req.query;

  if (!rollNumber) {
    return res.status(400).json({ 
      success: false,
      message: 'Roll number is required' 
    });
  }

  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute(
      `SELECT subject, attendance_percentage AS percentage 
       FROM attendance_report 
       WHERE roll_no = ?`,
      [rollNumber]
    );

    await connection.end();

    if (rows.length === 0) {
      return res.status(404).json({ 
        success: false,
        message: 'No attendance records found' 
      });
    }

    res.json({
      success: true,
      data: rows
    });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ 
      success: false,
      message: 'Internal server error' 
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Something broke!'
  });
  console.log(next);
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});