const express = require('express');
const router = express.Router();
const verifyJWT = require('../middleware/verifyJWT');
const Product = require('../models/Product');

// Todas as rotas exigem autenticação
router.use(verifyJWT);

// Criar produto
router.post('/', async (req, res) => {
  try {
    const { name, price, quantity } = req.body;
    
    const newProduct = new Product({
      name,
      price,
      quantity,
      user: req.userId
    });

    await newProduct.save();
    res.status(201).json(newProduct);

  } catch (error) {
    res.status(500).json({ message: 'Erro ao criar produto' });
  }
});

// Listar produtos
router.get('/', async (req, res) => {
  try {
    const products = await Product.find({ user: req.userId });
    res.json(products);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar produtos' });
  }
});

module.exports = router;