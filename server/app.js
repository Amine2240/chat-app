const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const Msgmodel = require("./models/msgmodel");
const app = express();
express.urlencoded({ extended: true });
app.use(express.json());
app.use(
  cors({
    credentials: true,
    origin: [
      "http://localhost:5000",
      "http://127.0.0.1:5000",
      "http://localhost:51114",
    ],
    //  origin: "http://localhost:53488",
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

app.get("/getmessage", async (req, res) => {
  try {
    const msgfound = await Msgmodel.find({});
    if (!msgfound) {
      return res.json("no message found");
    }
    return res.json({ result: msgfound });
  } catch (error) {
    res.json({ error: error });
  }
});

app.delete("/deletemessage/:id", async (req, res) => {
  try {
    const deletedmessage = await Msgmodel.findByIdAndDelete(req.params.id);
    if (!deletedmessage) {
      return res.json("not found");
    }
    return res.json({ msgtodelete: deletedmessage });
  } catch (error) {
    return res.json({ error: error });
  }
});

app.put("/updatemessage/:id", async (req, res) => {
  try {
    const messagetoupdate = await Msgmodel.findByIdAndUpdate(
      req.params.id,
      req.body.msg
    );
    if (!messagetoupdate) {
      return res.json({ notfound: "message not found in db" });
    }
    return res.json(messagetoupdate);
  } catch (error) {
    return res.json({ error: error });
  }
});

app.listen(5000, () => {
  console.log("connected to server");
});
