const express = require('express');
const userRoute = express.Router();
const auth = require('../middleware/auth');
const { Product } = require('../models/product');
const User = require('../models/user');

userRoute.post("/api/add-to-cart", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        let a = user.cart.findIndex((x) => x.product._id.equals(product._id));
        if(a<0) {
            user.cart.push({product, quantity: 1});
        } else {
            user.cart[a].quantity += 1;
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = userRoute;