class Word {

}

class HebText {
  static String text = "וַיֹּ֣אמֶר אֱלֹהִ֔ים יִשְׁרְצ֣וּ הַמַּ֔יִם שֶׁ֖רֶץ נֶ֣פֶשׁ חַיָּ֑ה וְעֹוף֙ יְעֹופֵ֣ף עַל־הָאָ֔רֶץ עַל־פְּנֵ֖י רְקִ֥יעַ הַשָּׁמָֽיִם";
  
  static List<String> textToList(String txt) {
    txt = txt.replaceAll("־", " ");
    List<String> txtList = txt.split(" ");
    return txtList;
  }
  
  static List<String> textList = HebText.textToList(HebText.text);
}

class TextObject {
  int? id;
  String? text;
  String type = "Some type";
  
  TextObject(this.id, this.text);
}

class TextObjects {
  static List<TextObject> items() {
    List<TextObject> items = [];
    List<String> txt = HebText.textList;
    for(int i = 0; i < txt.length; i++) {
      TextObject item = TextObject(i, txt[i]);
      items.add(item);
    }
    return items;
  }
  
}