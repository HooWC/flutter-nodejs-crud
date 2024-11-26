const express = require('express');
const router = express.Router();
const {
  getItems,
  createItem,
  updateItem,
  deleteItem
} = require('../controllers/itemController');

// 获取所有项
router.get('/', getItems);

// 创建新项
router.post('/', createItem);

// 更新项
router.put('/:id', updateItem);

// 删除项
router.delete('/:id', deleteItem);

module.exports = router;
