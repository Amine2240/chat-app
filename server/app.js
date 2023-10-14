const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const Msgmodel = require("./models/msgmodel");
const app = express();
app.use(express.json());
app.use(
  cors({
    credentials: true,
    // origin: ["http://localhost:5000", "http://127.0.0.1:5000"],
  })
);

mongoose
  .connect(
    "mongodb+srv://kadoumamine:9adoum2004@cluster0.afd6kpg.mongodb.net/test?retryWrites=true&w=majority"
  )
  .then(() => {
    console.log("connected to mongodb");
  })
  .catch((e) => {
    console.log("error in connecting to mongodb", e);
  });

app.post("/message", async (req, res) => {
  try {
    const newmsg = new Msgmodel({ msg: req.body.msg });
    console.log("req.body", req.body);
    // if (!newmsg) {
    //   return res.json("message is empty");
    // }
    await newmsg.save();
    return res.status(200).json({ success: "posted succsfully" });
  } catch (error) {
    return res.json({ error: error });
  }
});

app.listen(5000, () => {
  console.log("connected to server");
});
