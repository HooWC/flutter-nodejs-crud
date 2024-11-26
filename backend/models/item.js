const mongoose = require('mongoose');

// 定义 Schema
const itemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  }
});

const Item = mongoose.model('Item', itemSchema);

module.exports = Item;
