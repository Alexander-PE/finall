import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {


  var data = [];
  var cant = 0;


  Future<void> getVideos() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/videos.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      // await for(var vid in response.data['datos']){
      //   playlist.add(vid["link"]);
      // }
      setState(() {});
      // print(response.data['datos'][0]['nombre']);
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    getVideos();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Text("gola")
          // for (var i = 0; i<cant; i++) Text(data[i]["link"])
          Expanded(
            child: ListView.builder(
              itemCount: cant,
              itemBuilder: (context, index){
                return BuildCard(index, data, context);
              },
            ),
          )         
        ],
      ),
    );
  }
}


Widget BuildCard(int index, List data, context) => Container(
  color: Colors.grey,
  width: double.infinity,
  height: 100,
  child: Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(data[index]['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Video(titulo: data[index]["titulo"], link: data[index]["link"]))),
      ),
      const Divider(
            height: 20,
            thickness: 5,
            endIndent: 0,
            color: Colors.white,
          ),
    ],
  )),
);



class Video extends StatefulWidget {
  final String titulo;
  final String link;

  const Video({super.key, required this.titulo, required this.link});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!, 
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),

      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: Text(widget.titulo),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player
            ],
          ),
        )
      ),
    );
  }
}