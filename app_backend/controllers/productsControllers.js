const Product = require('../models/Product');

module.exports = {
    createProduct: async (req, res) => {
        const newProduct = new Product(req.body)
        try {
            await newProduct.save();
            res.status(200).json("product created")
        }catch (error) {
            res.status(500).json("failed")
        }
    },

    getAllProducts: async (req, res) => {
        try {
            const product = await Product.find().sort({createdAt: -1})
            res.status(200).json(product)
        }catch (error) {
            res.status(500).json("failed")
        }
    },

    getProduct: async (req, res) => {
        const productId = req.params.id
        try {
            const product = await Product.findById(productId)
            const {__v, createdAt, ...productData} = product._doc;
            res.status(200).json(productData)
        }catch (error) {
            res.status(500).json("failed")
        }
    },

    searchProducts: async (req, res) => {
        try {
            const results = await Product.aggregate(
                [
                    {
                      $search: {
                        index: "shoes",
                        text: {
                          query: req.params.key,
                          path: {
                            wildcard: "*"
                          }
                        }
                      }
                    }
                  ]
            )
            res.status(200).json(results)
        }catch (error) {
            res.status(500).json("failed")
        }
    }
}