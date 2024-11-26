const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const dbConnect = require('./config/dbConnect');
const itemRoutes = require('./routes/itemRoutes');

// 创建 Express 应用
const app = express();

// 配置中间件
app.use(cors());
app.use(bodyParser.json());

// 连接到 MongoDB
dbConnect();

// 使用路由
app.use('/items', itemRoutes);

// 启动服务器
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
