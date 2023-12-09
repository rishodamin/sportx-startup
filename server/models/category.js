const mongoose = require('mongoose');

const categorySchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
    },
    ordered: {
        type: Number,
        default: 0,
    },
    earnings: {
        type: Number,
        default: 0,
    },
});

const Category = mongoose.model('Category', categorySchema);
module.exports = Category;