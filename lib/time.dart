class timestamp {
  String inout;

  timestamp({this.inout});

  String y='';
  String m='';
  String d='';

  convert() {
    int k = 0;
    inout = inout.substring(0, 10);
    inout.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      if (character == '-') {
        //  a=a+',';
        k++;
      }
      else {
        if (k == 0) {
          y = y + character;
        }
        if (k == 1) {
          m = m + character;
        }
        if (k == 2) {
          d = d + character;
        }
      }
      // print(character);
    });
  }
}