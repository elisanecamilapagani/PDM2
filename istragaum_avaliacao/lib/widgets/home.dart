import 'dart:io';
import 'package:flutter/material.dart';
import 'package:istragaum/services/image_service.dart';
import 'package:istragaum/widgets/camera_view.dart';
import 'package:istragaum/widgets/imagem_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<String>> images;

  @override
  void initState() {
    super.initState();
    ImageService imgService = ImageService();
    images = imgService.retrieveImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
              image: AssetImage('images/Elisane.jpeg'),
            ),
          ),
        ),
        title: Text(
          'Istragaum',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black26,
            height: 1,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      body: Container(
        height: 500,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: FutureBuilder<List<String>>(
          future: images,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String>? imgList = snapshot.data;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (content) => ImagePage(imgList![index]),
                      ));
                    },
                    child: Image.file(
                      File(imgList![index]),
                      fit: BoxFit.cover,
                    )),
                itemCount: imgList!.length,
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (content) => CameraView(),
          ))
        },
        tooltip: 'Tirar foto',
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
