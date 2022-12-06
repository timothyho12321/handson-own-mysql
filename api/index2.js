const express = require('express');
const cors = require('cors');
require('dotenv').config();

// make sure to require the promise version of mysql2
// because we want to use await/async
const mysql2 = require('mysql2/promise');

const app = express();
app.use(cors());
app.use(express.json());  // req.body will be formatted as a JSON object


// routes
async function main() {
    const connection = await mysql2.createConnection({
        // ip address of the MySQL server
        'host': process.env.DB_HOST,
        'user': process.env.DB_USER,
        'database': process.env.DB_DATABASE,
        // leave password as blank because our root account has no password
        'password': process.env.DB_PASSWORD
    })

    app.get('/', function(req,res){
        res.send("Hello world");
    })


}