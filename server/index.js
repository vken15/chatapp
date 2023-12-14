const { Socket } = require("socket.io");
const app = require("./app");
//const http = require("http");

const port = process.env.PORT || 3000;

//const server = http.createServer(app);

const server = app.listen(port, () => {
  console.log(`Server started and running on port ${port}`);
});

const io = require("socket.io")(server);

io.on('connection', (socket) => {
  console.log("Connected!", socket.id);
  socket.on('disconnect', () => {
    console.log('Disconnected!', socket.id);
  });
  socket.on('message', (data) => {
    console.log(data);
  });
});