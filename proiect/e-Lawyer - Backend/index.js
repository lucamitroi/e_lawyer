const express = require('express');
const mongoose = require('mongoose');
const createError = require('http-errors');
const path = require('path');
const cors = require('cors');
require('dotenv').config();
const app = express();

const Police = require('./Routes/PoliceDepartment');
const User = require('./Routes/User');
const Complain = require("./Routes/Complaint");

// Set view engine and views directory
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Enable CORS
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH']
}));

// Parse incoming request data
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// Connect to MongoDB
mongoose.connect(process.env.DB_CONNECT, {
    dbName: process.env.DB_NAME,
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(() => {
        console.log('MongoDB connected...');
    })
    .catch((err) => {
        console.error('Something went wrong!', err.message);
    });

// Set up routes
app.use('/police', Police);
app.use('/user', User);
app.use('/complaint', Complain);
// 404 error handler
app.use((req, res, next) => {
    next(createError(404, 'Not found'));
});

// General error handler
app.use((err, req, res, next) => {
    res.status(err.status || 500);
    res.send({
        error: {
            status: err.status || 500,
            message: err.message
        }
    });
});

// Start server
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Listening on port ${port}...`);
});
