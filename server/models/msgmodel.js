const mongoose = require("mongoose");

const MsgSchema = new mongoose.Schema({
  msg: {
    type: String, 
    // required: true,
  },
});

const Msgmodel = mongoose.model("messages", MsgSchema);

module.exports = Msgmodel; 
