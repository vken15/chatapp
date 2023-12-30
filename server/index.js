const { Socket } = require("socket.io");
const app = require("./app");
const _ = require("lodash");
//const http = require("http");
const { secret } = require('config.json');
const jwt = require('jsonwebtoken');
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
  socket.auth = false;
  console.log(socket.id, "Connected!");
  var userID;
  socket.on('authenticate', function (data) {
    jwt.verify(data, secret, function (err, decoded) {
      if (!err) {
        console.log("Authenticated socket ", socket.id);
        socket.auth = true;
        socket.decoded = decoded;
        console.log(socket.decoded);
        userID = socket.decoded.sub;
        if (!users[userID]) users[userID] = [];
        users[userID].push(socket.id);
        if (onlineUsers.indexOf(userID) < 0) onlineUsers.push(userID);
        //get current online user
        console.log(onlineUsers);
        socket.emit('online-user-list', onlineUsers);
        socket.broadcast.emit('online-user', userID);
        console.log(userID, " online!");
        console.log(users);
      }
    });
  });

  setTimeout(function(){
    //sau 10s mà client vẫn chưa dc auth thì disconnect.
    if (!socket.auth) {
      console.log("Disconnecting socket ", socket.id);
      socket.disconnect('unauthorized');
    }
  }, 10000);

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

  socket.on('friend request', async (data) => {
    try {
      const status = data.status;
      const receiverId = data.receiverId;
      const model = {
        userId: userID,
        friendId: receiverId,
        status: status
      }
      console.log(model);
      if (status == 1) { //create friend request
        const friendRequest = await friendService.getById(receiverId, userID);
        if (friendRequest == 1) {
          await friendService.acceptFriend(model);
        }
        else {
          await friendService.create(model);
        }
      } else if (status == -1) { //reject friend request
        const model2 = {
          userId: receiverId,
          friendId: userID,
          status: status
        }
        await friendService.update(model2);
      } else if (status == -2) { //cancel friend request
        await friendService.delete(model);
      } else if (status == 2) { //accept friend request
        await friendService.acceptFriend(model);
      }
      let i = onlineUsers.indexOf(receiverId);
      if (i != -1) {
        socket.to(onlineUsers[i]).emit('update friend request', { userID, status });
      };
      socket.emit('update friend request', { 'id': receiverId, 'status': status });
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