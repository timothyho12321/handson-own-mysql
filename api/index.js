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
    // the connection object is created outside of all the route functions
    // so all route functions are able to access it
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

    // endpoint to get all the artists
    app.get('/artists', async function(req,res){
        // Mock query: SELECT * FROM Artist

        // connection.execute() will take in one SQL statement as the parameter
        // that SQL statement will be executed on the selected SQL database
        // take the first result of the array returned from connection.execute
        // and store it in the results variable
        const [results] = await connection.execute("SELECT * FROM Artist");
        // shortcut for `results = results[0]`
        res.json(results);
    })

    app.get('/albums', async function(req,res){
        /*
         SELECT Artist.Name, Album.AlbumId, Album.Title from Album JOIN Artist ON 
            Album.ArtistId = Artist.ArtistId
        */
       const [results] = await connection.execute(`SELECT Artist.Name, Album.AlbumId, Album.Title from Album JOIN Artist ON 
       Album.ArtistId = Artist.ArtistId`)

       res.json(results);
    })

    // endpoint to searh for employees by their title, first name, last name and hiredate
    // and for hire date, we can set a range
    // the search terms are provided via the query string
    app.get('/employees', async function(req,res){
        // create always true where query
        let query = "SELECT * FROM Employee WHERE 1";

        // check if the client wants to search by job title
        if (req.query.job_title) {
            query +=` AND Title LIKE "%${req.query.job_title}%"`
        }

        if (req.query.name) {
            query += ` AND (FirstName LIKE "%${req.query.name}%" OR LastName LIKE "%${req.query.name}%")`;

        }

        const [results] = await connection.execute(query);
        res.json(results);
    })
}
main();

app.listen(3000, function(){
    console.log("server has started");
})

