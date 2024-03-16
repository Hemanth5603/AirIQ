const express = require("express");
const precautions = require("./precautions.js");

const app = express();

app.use(express.json());

let personData = {};

const handlePost = async (data, type) => {
  personData["lat"] = data["lat"];
  personData["lon"] = data["lon"];
  personData["pData"] = data["pData"];

  let response;
  if (type == "short") {
    response = await precautions.short(personData);
  }
  if (type == "long") {
    response = await precautions.long(personData);
  }
  let finalData = {};
  try {
    finalData = JSON.parse(response.text());
  } catch (err) {
    console.log("Take a look: ", err);
  }
  return finalData;
};

app.post("/precautions/short", async (req, res) => {
  console.log(req.socket.address());
  res.send(await handlePost(req.body, "short"));
});

app.post("/precautions/long", async (req, res) => {
  console.log(req.socket.address());
  res.send(await handlePost(req.body, "long"));
});

app.post("/aqi", async (req, res) => {
  const data = await fetch(
    `https://api.waqi.info/feed/geo:${req.body.lat};${req.body.lon}/?token=6e4f6e00feba1e08cc548d4cc9fecc51de355508`
  ).then((res) => res.json());
  const value = data["data"]["aqi"];
  const extra = data["data"]["iaqi"];
  res.send({
    aqi: value,
    humidity: extra["h"]["v"],
    dew: extra["dew"]["v"],
    pm25: extra["pm25"]["v"],
    temperature: extra["t"]["v"],
  });
});

app.listen(3000);
