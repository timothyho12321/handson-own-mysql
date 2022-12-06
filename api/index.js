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

        if (req.query.min_date) {
            query += ` AND HireDate >="${req.query.min_date}"` 
        }

        if (req.query.max_date) {
            query += ` AND HireDate <="${req.query.max_date}"`;
        }

        const [results] = await connection.execute(query);
        res.json(results);
    });

    // when we create an endpoint for a RestFUL API,
    // the URL is always a noun. The HTTP method (ie, the GET, POST, PATCH, PUT, DESTROY)
    // reflects the intent of the "verb"
    // req.body.name will contain the name of the artist
    app.post('/artists', async function(req,res){
        // 1. create a mock query and try it in the database
        // INSERT INTO Artist (Name) VALUES ("Taylor Swift");
        const query = `INSERT INTO Artist (Name) VALUES ("${req.body.name}")`;
        const [results] = await connection.execute(query);
        res.json({
            'insertId': results.insertId
        });

    })

    // insert a new album
    // we assume:
    // req.body.title will contain the title of the album
    // req.body.artist_id will contain the ID of the artist that produces the album
    app.post("/albums", async function(req,res){
        // check if the artist_id
        // try to see if the artist with the given artist_id exists or not
        const [artists] = await connection.execute(
            `SELECT * FROM Artist WHERE ArtistId=${req.body.artist_id}`
        )

        // take note: connection.execute will always return an array of results
        // even if there is only one valid row
        if (artists.length > 0) {
            // continune to insert in the new album
            // INSERT INTO Album (Title, ArtistId) VALUES ("Jiangnan", 277 ); 
            const query = `INSERT INTO Album (Title, ArtistId) VALUES ("${req.body.title}", ${req.body.artist_id} )`;
            const [results] = await connection.execute(query);
            res.json({
                'insertId': results.insertId
            })
        } else {
            // if the artists array has length of 0, it means that the artist_id is invalid
            // (i.e the artist with the artist_id is not found)
            res.status(400);
            res.json({
                'error':"The artist with the given artist_id is not found"
            })

        }
    })

    // Create a new playlist
    // req.body.name : contain the name of the playlist
    // req.body.tracks: an array of track IDs that will be added to the playlist
    app.post('/playlists', async function(req,res){
        // SELECT * FROM Track WHERE TrackId IN (1,2,3,4)
        const [tracks] =  await connection.execute(
            `SELECT * FROM Track WHERE TrackId IN (${req.body.tracks.toString()})`
        );
        
        if (tracks.length == req.body.tracks.length) {
            // 1. create the playlist
            // INSERT INTO Playlist (Name) VALUES ("Test Playlist")
            const query = `INSERT INTO Playlist (Name) VALUES ("${req.body.name}")`;
            const [results] = await connection.execute(query);
            const newPlaylistID = results.insertId;
            for (let t of req.body.tracks) {
                const [results] = await connection.execute(
                    `INSERT INTO PlaylistTrack (PlaylistId, TrackId) VALUES (${newPlaylistID}, ${t})`
                );
            
          
            }
            res.json({
                'playlist_id': newPlaylistID
            })

        } else {
            // one or more of the given trackID is not found
            res.status(400);
            res.json({
                'error':"One or more of the given Track ID does not exist"
            })
        }
    });

    app.put("/artist/:artist_id", async function(req,res){

    })

}
main();

app.listen(3000, function(){
    console.log("server has started");
})

