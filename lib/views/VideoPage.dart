
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_saver/flutter_gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  File _cameraImage;
  File _video;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Page"),
      ),
      body: Container(
          child: Center()
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Video',
        child: Icon(Icons.add),
        onPressed: _pickImageFromCamera,
      ),
    );
  }


  @override
  void initState() {
    _requestPermission();
  }

  _saveVideo(File video) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/$video.mp4";
    // String fileUrl =
    //     video.toString();
    // await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
    //   print((count / total * 100).toStringAsFixed(0) + "%");
    // });
    final result = await FlutterGallerySaver.saveFile(savePath);
    print("saveFile result: " + result);
    _checkFileExists(result);
  }

  _requestPermission() async {
    if(Platform.isAndroid){
      if (await Permission.storage.request().isGranted) {
        print("android storage permission has granted");
      }else{
        print("android storage permission has denied");
      }
    }else if(Platform.isIOS){
      if (await Permission.photos.request().isGranted) {
        print("ios photos permission has granted");
      }else{
        print("ios photos permission has denied");
      }
    }else{
      print("platform not support");
    }
  }
  _checkFileExists(String filePath) async {
    if(Platform.isAndroid){
      if (await Permission.storage.request().isGranted) {
        File file =  File.fromUri(Uri.parse(filePath));
        print("isExists: ${file.existsSync()}");
      }
    }else if(Platform.isIOS){
      if (await Permission.photos.request().isGranted) {
        File file =  File.fromUri(Uri.parse(filePath));
        print("isExists: ${file.existsSync()}");
      }
    }else{
      print("platform not support");
    }
  }

  _pickImageFromCamera() async {
    PickedFile pickedFile = await _picker.getVideo(source: ImageSource.camera);

    File video = File(pickedFile.path);


    setState(() {
      _cameraImage = video;
      // _saveVideo(video);
      _saveVideo(video);
    });
  }



  // _pickVideo() async {
  //   PickedFile pickedFile = await _picker.getVideo(source: ImageSource.gallery);
  //   _video = File(pickedFile.path);
  //   _videoPlayerController = VideoPlayerController.file(_video)
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoPlayerController.play();
  //     });
  // }
}
