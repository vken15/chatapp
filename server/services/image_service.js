const multer = require("multer");
const base64ToImage = require('base64-to-image');

const multerStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "E:/flutter/chatapp_image_folder/");
    },
    filename: (req, file, cb) => {
        cb(null, `${file.originalname}`);
    },
});

const upload = multer({
    storage: multerStorage,
});

module.exports = {
    uploadPhoto,
    downloadPhoto
};

async function uploadPhoto(params) {
    var imageName = params.imageName
    var base64url = params.encodedImage  //receiving base64 url from frontend
    var base64Str = "data:image/png;base64," + base64url  //changing base64url to base64string
    var path = 'E:/flutter/chatapp_image_folder/';
    var optionalObj = {
        'fileName': imageName,
        'type': 'png'
    };
    base64ToImage(base64Str, path, optionalObj); //saving
    var image = base64ToImage(base64Str, path, optionalObj);
    console.log(image);
    //var imageUrl = '/' + imageName
    return imageName;
}

async function downloadPhoto(imageName) {
    var path = 'E:/flutter/chatapp_image_folder/';
    var optionalObj = {
        'fileName': imageName,
        'type': 'png'
    };
    base64ToImage(base64Str, path, optionalObj); //saving
    var image = base64ToImage(base64Str, path, optionalObj);
    console.log(image);
    //var imageUrl = '/' + imageName
    return imageName;
}