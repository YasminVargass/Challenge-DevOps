const express = require("express");

const app = express();

app.use(express.json());

app.set("view engine", "ejs");
app.set("views", "src/views");

app.get("/views/home", async (req, res) => {
    res.render("index");
  });

app.use((req, res, next) => {
  console.log(`Request Type: ${req.method}`);
  console.log(`Content Type: ${req.headers["content-type"]}`);
  console.log(`Date: ${new Date()}`);

  next();
});

const port = 8080;

app.listen(port, () => console.log(`Rodando com Express na porta ${port}!`));