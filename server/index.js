const { Socket } = require("socket.io");
const app = require("./app");
const _ = require("lodash");
//const http = require("http");
const userService = require('services/user_service');
const friendService = require('services/friend_service');

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

const users = {};
var onlineUsers = [];

io.on('connection', (socket) => {
  console.log(socket.id, "Connected!");

  var userID;

  socket.on('setup', (userId) => {
    userID = userId;
    if (!users[userId]) users[userId] = [];
    users[userId].push(socket.id);
    if (onlineUsers.indexOf(userId) < 0) onlineUsers.push(userId);
    //get current online user
    console.log(onlineUsers);
    socket.emit('online-user-list', onlineUsers);
    socket.broadcast.emit('online-user', userId);
    console.log(userId, " online!");
    console.log(users);
  });

  socket.on('typing', (room) => {
    console.log("typing", room);
    socket.to(room).emit('typing', room);
  });

  socket.on('stop typing', (room) => {
    console.log("stop typing", room);
    socket.to(room).emit('stop typing', room);
  });

  socket.on('join chat', (room) => {
    socket.join(room);
    console.log(socket.id, " joined: ", room);
  });

  socket.on('new message', (newMessageReceived) => {
    console.log('start');
    var room = newMessageReceived.chatId;

    var senderId = newMessageReceived.senderId;
    if (!senderId) {
      console.log("Sender not defined!");
      return;
    }

    console.log(senderId, " message sender");
    const users = [senderId, newMessageReceived.receiverId];
    if (!users) {
      console.log("Users not defined!");
      return;
    }

    socket.to(room).emit('message received', newMessageReceived);
    socket.to(room).emit('message sent', "New Message");
  });

  // socket.on('update profile photo', (id, encodedImage) => {
  //   try {
  //     //await userService.get
  //   } catch (e) {
  //     console.log(e);
  //   }
  // });
  socket.on('friend request', async (senderId, receiverId) => {
    try {
      const model = {
        userId: senderId,
        friendId: receiverId,
        status: 1
      }
      await friendService.create(model);
      let i = onlineUsers.indexOf(receiverId);
      if (i != -1) {
        socket.to(onlineUsers[i]).emit('update friend request', senderId);
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on('disconnect', () => {
    _.remove(users[userID], (u) => u === socket.id);
    if (users[userID]) {
      if (users[userID].length === 0) {
        socket.broadcast.emit('offline-user', userID);
        delete users[userID];
        let i = onlineUsers.indexOf(userID);
        delete onlineUsers[i];
        onlineUsers = onlineUsers.filter(Boolean);
        try {
          userService.updateLastOnline(userID);
        } catch (e) {
          console.log(e);
        }
      }
    }
    console.log(users);
    console.log(socket.id, 'Disconnected!');
  });
});