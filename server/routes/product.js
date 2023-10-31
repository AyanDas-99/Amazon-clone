const express = require("express");
const productRoute = express.Router();
const { Product } = require("../models/product");
const auth = require("../middleware/auth");

// fetch category products
productRoute.get("/api/products", auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({ category: req.query.category });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// fetch searched products
productRoute.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// rate a product
productRoute.post("/api/rate-product", auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId = req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating,
        };

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// deal of the day
productRoute.get("/api/deal-of-day", auth, async (req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;

            for (let i = 0; i < Math.max(a.ratings.length, b.ratings.length); i++) {
                if (a.ratings.length < i) {
                    aSum += a.ratings[i].rating;
                }
                if (b.ratings.length < i) {
                    bSum += b.ratings[i].rating;
                }
            }
            return (aSum < bSum) ? 1 : -1;
        });
        res.json(products[0]);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRoute;