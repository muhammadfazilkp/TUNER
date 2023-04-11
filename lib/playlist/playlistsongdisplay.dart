
import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/functions/playlistdatab.dart';
import 'package:project/model.dart/model.dart';

class playlistsongdisplayScreeen extends StatefulWidget {
  playlistsongdisplayScreeen({
    super.key,
    required this.playlist,
  });
  final Plyermodel playlist;
  @override
  State<playlistsongdisplayScreeen> createState() =>
      _playlistsongdisplayScreeenState();
}

final audioquery = OnAudioQuery();

class _playlistsongdisplayScreeenState
    extends State<playlistsongdisplayScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 15,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          'Add to playlist',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioquery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const CircularProgressIndicator();
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No Songd avalable'),
            );
          }
          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: 60,
                  artworkWidth: 60,
                  nullArtworkWidget: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.black,
                    ),
                  ),
                  
                  artworkBorder: BorderRadius.circular(10),
                  artworkFit: BoxFit.cover,
                ),
                title: Text(
                  item.data![index].displayNameWOExt,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  item.data![index].artist!,
                  style: GoogleFonts.poppins(color: Colors.white),
                  maxLines: 1,
                ),
                trailing: Wrap(
                  children: [
                    
                    !widget.playlist.isvaluele(item.data![index].id)
                    
                    ?IconButton(onPressed: (){

                      Getallsongs.copysong=item.data!;
                      setState(() {
                      songaddplaylist(item.data![index]);
                      PlaylistDB.playlistNotifier.notifyListeners();
                      });
                    }, icon: const Icon(Icons.add,color: Colors.white,))
                    :IconButton(onPressed: (){
                      setState(() {
                        widget.playlist.deleted(item.data![index].id);
                         const removesonglist = SnackBar(
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 1),
                          content: Center(
                          child: Text('music removed in playlist',style: TextStyle(color: Colors.black),),
                         ));
                         ScaffoldMessenger.of(context).showSnackBar(removesonglist);

                        
                      });
                    }, icon: const Icon(Icons.remove,color: Colors.white,))

                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
 songaddplaylist(SongModel data) {
   widget.playlist.add(data.id);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist',style:TextStyle(color: Colors.black,),)));
   ScaffoldMessenger.of(context).showSnackBar(addsongplaylistsnake);
  }
  


}
