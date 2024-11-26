const mongoose = require('mongoose'); // mongodb

const dbConnect = () => {
  mongoose.connect('mongodb://localhost:27017/flutter_crud', {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log("MongoDB connected");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
    process.exit(1);
  });
};

module.exports = dbConnect;
