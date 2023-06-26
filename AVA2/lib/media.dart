import 'dart:convert';
import 'dart:ffi';
import 'dart:html';
import 'dart:io';

abstract class Media {
  final MediaType type;
  final String title;
  final int duration;

  Media(this.type, this.title, this.duration);
  String get name;
}

enum MediaType {
  book;
  movie;
  music;
}
class AudioBook extends Media{
  final String author;
  
  AudioBook(String title, int duration, this.author)
   :super(MediaType.book, title, duration);

   @override
   String get name => author;
} 
class Movie extends Media{
  final String director;

  Movie(String title, int duration, this.director)
    :super(MediaType.movie, title, duration);

   @override
   String get name => director;

}
class Music extends Media{
  final String artist;
  
  Music(String title, int duration, this.artist)
    :super(MediaType.music, title, duration);

    @override
    String get name => artist;
}

class DigitalLibrary{
  List<Media>medialist = [];

 Void loadMedia(){
   final file = File('data.json');
   if (file.existsSync()){
     final jsonData = jsonDecode(file.readAsStringSync());
     for (final data in jsonData){
       final type = data ['type'] as String;
       final title = data ['title'] as String;
       final duration = data ['duration'] as int;
       switch(type){
         case 'book':
          final author = data ['author'] as String;
          medialist.add(AudioBook(title, duration, author));
          break;
          case 'movie':
          final director = data ['director'] as String;
          medialist.add(Movie(title, duration, director));
          break;
          case 'music':
          final artist = data ['artist'] as String;
          medialist.add(Music(title, duration, artist));
          break;

       }
     }
   }
 }
  Void listMedia(MediaType ? type){
    for(final media in medialist){
      if(type == null || media.type == type){
        print("Title: ${media.title}");
        print("Type: ${media.type}");
        print("Duration: ${media.duration}minutos");
        print("Name: ${media.name}");
        print("Title: ${media.title}");

      }
    }

  } 
  Void addMedia(){
    medialist.add(media);

  }
  int totalMediaDuration({MediaType ? type}){
  int totalDuration = 0;
  for(final media in medialist){
    if(type == null || media.type == type){
      totalDuration += media.duration;
    }


}
return totalDuration;
  }
}