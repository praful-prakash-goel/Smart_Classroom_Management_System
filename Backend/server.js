require('dotenv').config();
const express = require("express");
const cors = require("cors");
const indexRouter = require('./Routes/indexRoute');

const app = express();

app.use(cors({
  origin: "http://localhost:5173",
  credentials: true,
}));

app.use(express.json());
app.use(express.static('public'));

app.use("/", indexRouter)

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
