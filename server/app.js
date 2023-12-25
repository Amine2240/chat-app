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
    // origin: [
    //   "http://localhost:5000",
    //   "http://127.0.0.1:5000",
    //   "http://localhost:51114",
    // ],
    //  origin: "http://localhost:53488",
  })
);
const OpenAi = require("openai");
require("dotenv").config();

mongoose
  .connect(process.env.connect_url)
  .then(() => {
    console.log("connected to mongodb");
  })
  .catch((e) => {
    console.log("error in connecting to mongodb", e);
  });

app.post("/message", async (req, res) => {
  try {
    const newmsg = new Msgmodel({ msg: req.body.msg });
    // console.log("req.body", req.body);
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
    return res.status(200).json({ result: msgfound });
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
    return res.json({ messagetoupdate });
  } catch (error) {
    return res.json({ error: error });
  }
});
const openai = new OpenAi({
  apiKey: process.env.apiKey,
});
app.post("/chatgpt/api", async (req, res) => {
  try {
    const completion = await openai.chat.completions.create({
      messages: [
        { role: "system", content: "You are a helpful assistant." },
        { role: "user", content: "Who won the world series in 2020?" },
        {
          role: "assistant",
          content: "The Los Angeles Dodgers won the World Series in 2020.",
        },
        { role: "user", content: `${req.body.promptresult}` },
      ],
      model: "ft:gpt-3.5-turbo-0613:personal::8TMJd7BI",
    });
    // console.log(
    //   "gpt response from backend : ",
    //   completion.choices[0].message.content
    // );
    return res.json({ gptanswer: completion.choices[0].message.content });
  } catch (error) {
    console.log(error);
    return res.json({ error: error.message });
  }
});

app.listen(5000, () => {
  console.log("connected to server");
});
