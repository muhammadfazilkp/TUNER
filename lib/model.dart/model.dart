import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class Plyermodel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songid;
  Plyermodel({required this.name,required this.songid
  });
  add(int id){
    songid.add(id);
    save();

  }
  deleted(int id){
    songid.remove(id);
    save();

  }
  bool isvaluele(int id){
    return songid.contains(id);

  }
}