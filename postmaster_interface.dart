import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:sih_app/PostMasterScreens/dashboard.dart';
import 'package:sih_app/PostMasterScreens/detail_db.dart';
import 'package:sih_app/PostMasterScreens/drawer.dart';
import 'package:sih_app/theme.dart';

class PostmasterInterface extends StatefulWidget {
  const PostmasterInterface({super.key});

  @override
  State<PostmasterInterface> createState() => _PMState();
}

class _PMState extends State<PostmasterInterface> {
  // void cameraPicker() async {
  //   final ImagePicker image = ImagePicker();
  //   XFile? file = await image.pickImage(source: ImageSource.camera);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue.shade100,
        title: const Text('Postmaster Interface',style: TextStyle(fontWeight : FontWeight.bold),),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const DrawerMenu(),
      body: themeContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CCTV Feed Button
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(255, 48, 145, 92),
              //       shape: const CircleBorder(),
              //       padding: const EdgeInsets.all(30),
              //       elevation: 8,
              //       shadowColor: const Color.fromARGB(255, 116, 199, 134),
              //     ),
              //     onPressed: () {
              //       cameraPicker();
              //     },
              //     child: Icon(
              //       MdiIcons.cctv,
              //       size: 60,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // const Text(
              //   'CCTV Feed',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              const SizedBox(height: 40),

              // Dashboard
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 97, 129),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    elevation: 8,
                    shadowColor: const Color.fromARGB(255, 151, 231, 223),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const DetailDb(), // here it was DashBoard()
                      ),
                    );
                  },
                  child: Icon(
                    MdiIcons.viewDashboard,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              //queue management
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(255, 197, 75, 75),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 20,
              //         horizontal: 40,
              //       ),
              //       elevation: 8,
              //       shadowColor: const Color.fromARGB(255, 255, 167, 167),
              //     ),
              //     onPressed: () {},
              //     child: Icon(
              //       MdiIcons.humanQueue,
              //       size: 60,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // const Text(
              //   'Queue Mnagement',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:sih_app/PostMasterScreens/detail_db.dart';
// import 'package:sih_app/PostMasterScreens/drawer.dart';
// import 'package:sih_app/theme.dart';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'dart:ui' as ui;


// class PostmasterInterface extends StatefulWidget {
//   const PostmasterInterface({super.key});

//   @override
//   State<PostmasterInterface> createState() => _PMState();
// }

// class _PMState extends State<PostmasterInterface> {
//   // void cameraPicker() async {
//   //   final ImagePicker image = ImagePicker();
//   //   XFile? file = await image.pickImage(source: ImageSource.camera);

//   //   if (file != null) {
//   //     Navigator.pushNamed(context, '/video_feed');
//   //   }
//   // }
//   void cameraPicker() async {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VideoFeedScreen(),
//         ));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade100,
//         title: const Text('Postmaster Interface',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         leading: Builder(
//           builder: (context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           },
//         ),
//       ),
//       drawer: const DrawerMenu(),
//       body: themeContainer(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // CCTV Feed Button
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 48, 145, 92),
//                     shape: const CircleBorder(),
//                     padding: const EdgeInsets.all(30),
//                     elevation: 8,
//                     shadowColor: const Color.fromARGB(255, 116, 199, 134),
//                   ),
//                   onPressed: () {
//                     cameraPicker();
//                   },
//                   child: Icon(
//                     MdiIcons.cctv,
//                     size: 60,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const Text(
//                 'CCTV Feed',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Dashboard
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 17, 97, 129),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 20,
//                       horizontal: 40,
//                     ),
//                     elevation: 8,
//                     shadowColor: const Color.fromARGB(255, 151, 231, 223),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const DetailDb(),
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     MdiIcons.viewDashboard,
//                     size: 60,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const Text(
//                 'Dashboard',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Queue Management
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 197, 75, 75),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 20,
//                       horizontal: 40,
//                     ),
//                     elevation: 8,
//                     shadowColor: const Color.fromARGB(255, 255, 167, 167),
//                   ),
//                   onPressed: () {},
//                   child: Icon(
//                     MdiIcons.humanQueue,
//                     size: 60,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const Text(
//                 'Queue Management',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // class VideoFeedScreen extends StatefulWidget {
// //   @override
// //   _VideoFeedScreenState createState() => _VideoFeedScreenState();
// // }

// // class _VideoFeedScreenState extends State<VideoFeedScreen> {
// //   late http.Client client;
// //   late http.Response response;
// //   Uint8List? imageBytes;

// //   @override
// //   void initState() {
// //     super.initState();
// //     client = http.Client();
// //     _startVideoStream();
// //   }

// //   void _startVideoStream() async {
// //     try {
// //       // Connect to the Flask server endpoint
// //       var url = Uri.parse('http://127.0.0.1:5000/video_feed');

// //       client.send(http.Request('GET', url)).asStream().listen((http.StreamedResponse streamedResponse) {
// //         streamedResponse.stream.listen((List<int> chunk) {
// //           if (chunk.isNotEmpty) {
// //             setState(() {
// //               imageBytes = Uint8List.fromList(chunk);
// //             });
// //           }
// //         });
// //       });
// //     } catch (e) {
// //       print("Failed to connect to the server: $e");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('CCTV Feed'),
// //       ),
// //       body: Center(
// //         child: imageBytes == null
// //             ? CircularProgressIndicator() 
// //             : Image.memory(imageBytes!), 
// //       ),
// //     );
// //   }
// // }




// class VideoFeedScreen extends StatefulWidget {
//   @override
//   _VideoFeedScreenState createState() => _VideoFeedScreenState();
// }

// class _VideoFeedScreenState extends State<VideoFeedScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // Register the view type for HTML video
//     ui.platformViewRegistry.registerViewFactory(
//       'videoElement',
//       (int viewId) => html.VideoElement()
//         ..src = 'http://<YOUR_SERVER_IP>:5000/video_feed'
//         ..controls = true
//         ..autoplay = true
//         ..style.width = '100%'
//         ..style.height = 'auto',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CCTV Feed'),
//       ),
//       body: Center(
//         child: HtmlElementView(
//           viewType: 'videoElement',
//         ),
//       ),
//     );
//   }
// }
