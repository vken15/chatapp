const { Socket } = require("socket.io");
const app = require("./app");
//const http = require("http");

const port = process.env.PORT || 3000;

//const server = http.createServer(app);

const server = app.listen(port, () => {
  console.log(`Server started and running on port ${port}`);
});

const io = require("socket.io")(server, {
  pingTimeOut: 60000,
  cors: {
    origin: "http:localhost:5001"
  }
});

io.on('connection', (socket) => {
  console.log(socket.id, "Connected!");

  socket.on('setup', (userId) => {
    socket.join(userId);
    socket.broadcast.emit('online-user', userId);
    console.log(userId, " online!");
  });

  socket.on('typing', (room) => {
    console.log("typing", room);
    socket.to(room).emit('typing', room);
  });

  socket.on('typing', (room) => {
    console.log("stop typing", room);
    socket.to(room).emit('stop typing', room);
  });

  socket.on('join chat', (room) => {
    socket.join(room);
    console.log(socket.id, " joined: ", room);
  });

  socket.on('new message', (newMessageReceived) => {
    //var chat = newMessageReceived.chat;
    //var room = chat;
    console.log('start');
    var room = newMessageReceived.chatId;

    // var sender = newMessageReceived.sender;
    var senderId = newMessageReceived.senderId;
    // if (!sender || sender.id) {
    if (!senderId) {
      console.log("Sender not defined!");
      return;
    }

    //var senderId = sender.id;
    console.log(senderId, " message sender");
    //const users = chat.users;
    const users = [senderId, newMessageReceived.receiverId];
    if (!users) {
      console.log("Users not defined!");
      return;
    }

    socket.to(room).emit('message received', newMessageReceived);
    socket.to(room).emit('message sent', "New Message");
  });

  socket.off('setup', () => {
    console.log('user offline');
    socket.leave(userId);
  });

  socket.on('disconnect', () => {
    console.log('Disconnected!', socket.id);
  });
});