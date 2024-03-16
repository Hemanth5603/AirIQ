const { GoogleGenerativeAI, HarmCategory, HarmBlockThreshold } = require("@google/generative-ai");
require("dotenv").config();

const MODEL_NAME = "gemini-1.0-pro";
const API_KEY = process.env.GEMINI_API_KEY;
const genAI = new GoogleGenerativeAI(API_KEY);
const model = genAI.getGenerativeModel({ model: MODEL_NAME });

const generationConfig = {
  temperature: 0.9,
  topK: 1,
  topP: 1,
  maxOutputTokens: 2048,
};

const safetySettings = [
  {
    category: HarmCategory.HARM_CATEGORY_HARASSMENT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
];

async function long({ type, lat, lon, pData }) {
  const aqiData = await fetch(
    `https://api.waqi.info/feed/geo:${lat};${lon}/?token=6e4f6e00feba1e08cc548d4cc9fecc51de355508`
  ).then((res) => res.json());

  const longInputPart = `input: Here is some basic respiratory details of a person:\n${pData}\nAnd here is the current aqi index details and other atmospheric gas levels:\n${aqiData}\nGive me a article containing 200 to 350 words in stringified JSON format (use double quotes only) like below based on the above data:\n{"title": "/*a catchy and easy-to-understand title goes here*/","paragraphs": ["The introduction text goes here","The middle paragraph goes here","A conclusion with a call-to-action goes here", "an extra paragraph if required"]}`;

  const parts = [
    {
      text: longInputPart,
    },
    {
      text: 'output: {"title": "Taipei Air Quality: Moderate Risk for Sensitive Groups","paragraphs": ["Air quality in Taipei is currently moderate, with an AQI of 151. This means that the air quality is acceptable for most people, but sensitive groups such as the elderly, children, and those with respiratory conditions may experience some discomfort. The dominant pollutant is PM2.5, which is particulate matter with a diameter of 2.5 micrometers or less.","PM2.5 can be harmful to health, as it can penetrate deep into the lungs and cause respiratory problems such as asthma, bronchitis, and lung cancer. Sensitive groups should take precautions to reduce their exposure to PM2.5, such as wearing a mask when outdoors or staying indoors when air quality is poor.","The air quality forecast for Taipei is stable for the next few days. However, it is important to check the air quality index before going outdoors, as it can change quickly. You can check the air quality index on the Air Quality Index website or by using the Air Quality Index app.","If you have any concerns about the air quality, please consult with your doctor or a healthcare professional."]}',
    },
    {
      text: longInputPart,
    },
    {
      text: 'output: {"title": "Mumbai Air Quality: Moderate Risk for Sensitive Groups","paragraphs": ["The air quality in Mumbai is currently moderate, with an AQI of 97. This means that the air quality is acceptable for most people, but sensitive groups such as the elderly, children, and those with respiratory conditions may experience some discomfort. The dominant pollutant is PM2.5, which is particulate matter with a diameter of 2.5 micrometers or less.","PM2.5 can be harmful to health, as it can penetrate deep into the lungs and cause respiratory problems such as asthma, bronchitis, and lung cancer. Sensitive groups should take precautions to reduce their exposure to PM2.5, such as wearing a mask when outdoors or staying indoors when air quality is poor.","The air quality forecast for Mumbai is stable for the next few days. However, it is important to check the air quality index before going outdoors, as it can change quickly. You can check the air quality index on the Air Quality Index website or by using the Air Quality Index app.","If you have any concerns about the air quality, please consult with your doctor or a healthcare professional."]}',
    },
    { text: "input: " },
    { text: "output: " },
  ];

  const result = await model.generateContent({
    contents: [{ role: "user", parts }],
    generationConfig,
    safetySettings,
  });

  const response = result.response;
  return response;
}

async function short({ type, lat, lon, pData }) {
  const aqiData = await fetch(
    `https://api.waqi.info/feed/geo:${lat};${lon}/?token=6e4f6e00feba1e08cc548d4cc9fecc51de355508`
  ).then((res) => res.json());

  const shortInputPart = `input: Here is some basic respiratory details of a person:\n${pData}\nAnd here is the current aqi index details and other atmospheric gas levels:\n${aqiData}\nGive me the top 3 precautions that this person can take, in order from most important to moderately important in the following JSON format (use double quotes only) only:\n{\n  "topic": "precautions",\n  "p1": "/* the most important precaution goes here */",\n  "p2": "/* the next most important precaution goes here */",\n  "p3": "/* the final most important precaution goes here */"\n}`;

  const parts = [
    {
      text: shortInputPart,
    },
    {
      text: 'output: {"topic": "precautions", "p1": "Monitor air quality and stay indoors when it is poor.", "p2": "Wear a mask outdoors to reduce exposure to particulate matter.", "p3": "Avoid strenuous activity outdoors when air quality is poor."}',
    },
    {
      text: shortInputPart,
    },
    {
      text: 'output: {"topic": "precautions", "p1": "Monitor air quality and stay indoors when it is poor.", "p2": "Wear a mask outdoors to reduce exposure to particulate matter.", "p3": "Avoid strenuous activity outdoors when air quality is poor."}',
    },
    { text: "input: " },
    { text: "output: " },
  ];

  const result = await model.generateContent({
    contents: [{ role: "user", parts }],
    generationConfig,
    safetySettings,
  });

  const response = result.response;

  return response;
}

module.exports = { long, short };
