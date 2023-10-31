const express = require('express');
const bcrypt = require('bcryptjs');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth')
const authRoute = express.Router();

authRoute.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existingEmails = await User.findOne({ email });
        if (existingEmails) {
            return res.status(400).json({ msg: "User with the same email already exists" });
        }

        const hashedPassword = await bcrypt.hash(password, 8);


        let user = new User({
            name,
            email,
            password: hashedPassword,
        });

        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


authRoute.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email does not exist" });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password" });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRoute.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) res.json(false);
        const user = User.findById(verified.id);
        if (!user) res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// get user data
authRoute.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})

module.exports = authRoute;