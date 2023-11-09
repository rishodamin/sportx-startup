//import from packages
const express = require('express');
const mongoose = require('mongoose');

const router = express.Router();


//import from other files
const authRouter = require('./routes/auth');

//init
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://daminrisho:Legendary123@cluster0.9yj6tbk.mongodb.net/?retryWrites=true&w=majority"

//middleware
app.use(express.json());
app.use(authRouter);

//coneections
mongoose.connect(DB).then(()=>{
    console.log('connected to the database');
}).catch((e)=>{
    console.log(e);
});

//creating an api

app.get("/messages", (req, res) => {
    res.send("Hello");
 });

app.listen(PORT, '0.0.0.0', ()=>{
    console.log(`Connected at port ${PORT}`);
});