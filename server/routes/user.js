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
        if (a < 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            user.cart[a].quantity += 1;
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

userRoute.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    console.log('Deleting a very important thing');
    try {
        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for(let i=0; i < user.cart.length; i++) {
            if(user.cart[i].product._id.equals(product._id)) {
                if(user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
            }
        }
        
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = userRoute;