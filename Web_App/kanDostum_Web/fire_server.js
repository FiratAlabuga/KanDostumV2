const express = require("express")
const server = express()
const SERVER_PORT = 5000;
var path = require('path')
//config server to show extra static content
server.use('/features',express.static(path.join(__dirname, 'features')));

//body form
server.use(express.urlencoded({ extended: true }))

//firebase connection on KanDostum
const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

firebase.initializeApp({
    apiKey: " ",
    authDomain: " ",
    databaseURL: " ",
    projectId: " ",
    storageBucket: " ",
    messagingSenderId: " ",
    appId: " ",
    measurementId: " "
  });
  
var db = firebase.firestore();

//config template engine
const nunjucks = require("nunjucks")
nunjucks.configure("./", {
    express: server,
    noCache: true,
})

server.get("/",  async function (req, res) {
    await db.collection("Web_Users").get().then((querySnapshot) => {
        const donors=res.rows
        querySnapshot.forEach((doc) => {
            console.log(`${doc.id} => ${doc.data()}`);
            console.log("merhaba")
            
            
        });
        return res.render("index.html",{donors})
    });
    
})



server.post("/", async function (req, res) {
    const adsoyad = req.body.adsoyad
    const email = req.body.email
    const kanG = req.body.kanG
    const telNu=req.body.telNu
    const varsaMesaj=req.body.varsaMesaj

    if (adsoyad == "" || email == "" || kanG == "" || telNu==""){
        return res.send("Alanlar Boş Geçilmez.")
    }

    await db.collection("Web_Users").add({
        adSoyad: adsoyad,
        email: email,
        telefonNu: telNu,
        kanGrubu: kanG,
        varsaMesaj:varsaMesaj
    })
    .then((docRef) => {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch((error) => {
        console.error("Error adding document: ", error);
    });

    return res.redirect("features/tesekkürler.html")
})


server.listen(SERVER_PORT, function() {
    console.log(`Server listen on ${SERVER_PORT}`)
})
