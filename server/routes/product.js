const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const {Product} = require('../models/product');
const ratingSchema = require('../models/rating');

// Get product by category
productRouter.get('/api/products', auth, async (req, res) => {
    try {
        const products = await Product.find({category: req.query.category});
        return res.json(products);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Get product by search
productRouter.get('/api/products/search/:name', auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: {$regex: req.params.name, $options: "i"},
        });
        return res.json(products);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Get deal of the day

productRouter.get('/api/deal-of-the-day', auth, async (req, res)=>{
    try{
        let products = await Product.find({});
        if (products.length==0){
            return res.json({});
        }

        var date = new Date().getDate();
        var index = (date*777)%products.length; // here 777 is a seed number
        return res.json(products[index]);
        
    } catch (e){
        return res.status(500).json({ error: e.message});
    }
});


// create api for post rating
productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        const {id, rating} = req.body;
        let product = await Product.findById(id);
        
        for (let i=0; i<product.ratings.length; i++){
            if (product.ratings[i].userId==req.user) {
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
        return res.json(product);
        
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})




module.exports = productRouter;