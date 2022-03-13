import 'dart:developer';

class TimeParser{
  int w = 0;
  int d = 0;
  int h = 0;
  int m = 0;
  int s = 0;
  String uptimeLimit;

  TimeParser(this.uptimeLimit);

  List<String> splitTime(){
    return uptimeLimit.split(RegExp("(?<=\\D)(?=\\d)|(?<=\\d)(?=\\D)"));
  }
  void assignTiming(){
    List<String> sp = splitTime();
    sp.asMap().forEach((index, element){
      switch(element){
        case "w":
          w = int.parse(sp[index-1]);
          break;
        case "d":
          d = int.parse(sp[index-1]);
          break;
        case "h":
          h = int.parse(sp[index-1]);
          break;
        case "m":
          m = int.parse(sp[index-1]);
          break;
        case "s":
          s = int.parse(sp[index-1]);
          break;
      }
    });
  }
  String addHour(int hour){
    assignTiming();
    if( (h + hour) > 24 ){
      double dayFloor = hour / 24;
      d+=dayFloor.floor();
      h = (hour + h ) - (24 * dayFloor.floor());
    }else{
      h+=hour;
    }
    return "${w}w${d}d${h}h${m}m${s}s";
  }
  String subHour(int hour){
    assignTiming();
    if(h < hour){
      // assuming t = 3d0h
      double dayFloor = hour / 24; //2.1
      d-= dayFloor.floor(); // -2  1d0h
      int hOffset = hour -  (24 * dayFloor.floor()); // 1
      if(h < hOffset){
        if(d > 0){
          d-=1;
          h = 24 - hOffset;
        }else{
          d = 0;
        }
      }else{
        h-= hOffset;
      }
    }else{
      h-= hour;
    }
    log(d.toString());
    log(h.toString());
    return "${w}w${d}d${h}h${m}m${s}s";
  }
}