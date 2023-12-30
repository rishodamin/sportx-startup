const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email addres',
        },
    },
    password: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value)=>{
                return value.length>6;
            },
            message: "Please enter a long password",
        },
    },
    address: [
        {
        type: String,
        }
    ],
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
            size: {
                type: String,
                default: '',
            },
        }
    ],
});

const User = mongoose.model('User', userSchema);
module.exports = User;