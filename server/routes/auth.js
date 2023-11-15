const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

// sign up
authRouter.post('/api/signup', async (req, res)=>{
    try{
    const {name, email, password} = req.body;

    const existingUser = await User.findOne({email});
    if (existingUser){
        return res.status(400).json({msg : "User with same email already exists! "});
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    let user = new User({
        email, 
        password: hashedPassword,
        name
    });
    user = await user.save();
    return res.json(user);
} catch(e){
    return res.status(500).json({error: e.message});
}
});

authRouter.post('/api/signin', async (req, res) => {
  try{
    const {email, password} = req.body;
    const user = await User.findOne({email});
    if (!user) {
        return res.status(400).json({msg: "User with this email does not exists!"});
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch){
        return res.status(400).json({msg: "Incorrect password."});
    }
    const token = jwt.sign({id: user._id}, "passwordKey");
    return res.json({token, ...user._doc});
  } catch (e) {
    return res.status(500).json({error: e.message});
  }
});

authRouter.post('/tokenIsValid', async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);
    const isVerified =  jwt.verify(token, "passwordKey");
    if(!isVerified) return res.json(false);

    const user = await User.findById(isVerified.id);
    if(!user) return res.json(false);
    return res.json(true);
  } catch (e) {
    return res.status(500).json({error: e.message});
  }
});

// get user data
authRouter.get('/', auth, async (req, res) => {
  const user = await User.findById(req.user);
  return res.json({ ...user._doc, token: req.token});
})

module.exports = authRouter;