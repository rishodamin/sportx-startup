const express = require('express');
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');
const Category = require('../models/category');
const userRouter = express.Router();

// Add cart
userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        let res_product = await user.cart.find((prod)=>prod.product._id.equals(product._id));
        if (res_product==null){
            user.cart.push({ product, quantity : 1});
        } else {
            res_product.quantity += 1;
        }
        user = await user.save();
        return res.json({cart:user.cart});
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Add cart
userRouter.post('/api/remove-from-cart/:id', auth, async (req, res) => {
    try {
        const {id} = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for (let i=0; i<user.cart.length; i++){
            if (user.cart[i].product._id.equals(product._id)){
                if (user.cart[i].quantity == 1){
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
                break;
            }
        }

        user = await user.save();
        return res.json({cart:user.cart});
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Save address
userRouter.post('/api/save-user-address', auth, async (req, res) => {
    try {
        const {address} = req.body;
        let user = await User.findById(req.user);
        user.address = address;
        user = await user.save();
        return res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

//order product
userRouter.post('/api/order', auth, async (req, res) => {
    try {
        const {cart, totalPrice, address} = req.body;
        let products = [];

        for (let i=0; i<cart.length; i++){
           let product = await Product.findById(cart[i].product.id);
            if(product.quantity>=cart[i].quantity){
                product.quantity -= cart[i].quantity
                products.push({product, quantity: cart[i].quantity});
                let category = await Category.findOne({"name":product.category});
                if (category==null){
                    category = new Category({
                        "name": product.category,
                    });
                }
                category.earnings += product.finalPrice;
                category.ordered += 1;
                category.save();
            } else {
                return res.status(400).json({msg: `${product.name} is out of stock now!`});
            }
        }
        for (let i=0; i<products.length; i++){
            await products[i].product.save();
        }


        let user = await User.findById(req.user);
        user.cart = [];
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),
        });
        order = await order.save()
        return res.json(order);

    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

userRouter.get('/api/my-orders', auth, async (req, res) => {
    try {
        const orders = await Order.find({userId: req.user});
        res.json(orders);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})





module.exports = userRouter;