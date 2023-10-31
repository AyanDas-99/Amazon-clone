// Package imports
const express = require('express');
const mongoose = require('mongoose');

// File imports
const authRoute = require('./routes/auth')
const adminRoute = require('./routes/admin')
const productRoute = require('./routes/product');
const userRoute = require('./routes/user');

// Init
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://AyanDas:clusterpassword@cluster0.9kftrwh.mongodb.net/?retryWrites=true&w=majority&appName=AtlasApp"

// middleware
app.use(express.json());
app.use(authRoute);
app.use(adminRoute);
app.use(productRoute);
app.use(userRoute);

// Creating API
app.get("/hello", (req, res) => {
    res.json({
        hi: "Hi! How are you doing?",
        val: req.body,
    })
});


// DB connections
mongoose.connect(DB).then(()=> {
    console.log('Connection Successfull')
}).catch(e => {
    console.log(e)
})


app.listen(PORT, "0.0.0.0", ()=> {
    console.log(`Connected to port: ${PORT}`)
})