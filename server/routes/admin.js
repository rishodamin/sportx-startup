const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const Order = require('../models/order');
const Category = require('../models/category');

// Add product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category, finalPrice} = req.body;
        
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            finalPrice,
            category,
        });
        product = await product.save();
        return res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Get product
adminRouter.get('/admin/get-product', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        return res.json(products);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Delete the product
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        return res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// Get orders
adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        return res.json(orders);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})


// Change Order status
adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try {
        const {id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        return res.json(order);
    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})

// View Earnings
adminRouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const category = await Category.find({});
        let totalEarnings = 0;
        let earnings = new Map();

        for(let i=0; i<category.length; i++){
            totalEarnings += category[i].earnings;
            earnings.set(category[i].name, category[i].earnings);
        }
        earnings.set("totalEarnings", totalEarnings);
        return res.json(Object.fromEntries(earnings));

    } catch (e) {
        return res.status(500).json({ error: e.message});
    }
})



module.exports = adminRouter;