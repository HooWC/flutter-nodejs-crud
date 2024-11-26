const mongoose = require('mongoose');

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
    process.exit(1);  // Exit the process with failure
  });
};

module.exports = dbConnect;