const express = require('express');
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const userRouter = express.Router();

// Add cart
userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        let res_product = await user.cart.find((prod)=>prod.product._id.equals(product._id));
        if (res_product==null){
           // return res.send('fuck');
            user.cart.push({ product, quantity : 1});
        } else {
          // return res.send(res_product);
            res_product.quantity += 1;
        }
        user = await user.save();
        return res.json({cart:user.cart});
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

module.exports = userRouter;