import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Note {
  final String title;
  final String text;

  Note(this.title, this.text);
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Список заметок'),
      ),
      body: new Form(),
    );
  }
}

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(32.0), child: new CreateNotes()

      //new ListNotes()

    );
  }
}

class CreateNotes extends StatefulWidget {
  @override
  _CreateNotesState createState() => new _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final TextEditingController label = new TextEditingController();
  final TextEditingController text = new TextEditingController();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<Note> notes = new List<Note>();
  int isChange = -1;

  void _listChanged(List<Note> n) {
    setState(() {
      notes = n;
    });
  }

  void _deleteItem(int position) {
    setState(() {
      notes.removeAt(position);
      isChange = -1;
      label.clear();
      text.clear();
    });
  }

  void _setIsChange(int position) {
    setState(() {
      isChange = position;
      label.text = notes[position].title;
      text.text = notes[position].text;
    });
  }

  void _changeItem(int position) {
    setState(() {
      notes.removeAt(position);
      notes.insert(position, new Note(label.text, text.text));
      isChange = -1;
      label.clear();
      text.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          "Заметка",
          style: _biggerFont,
          textAlign: TextAlign.left,
        ),

        new Container(
          margin: new EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.black26),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))
          ),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: new TextField(
              controller: label,
              decoration: new InputDecoration(
                hintText: 'Type something',
              ),
            ),
          ),
        ),
        new Text(
          "Примечание",
          style: _biggerFont,
          textAlign: TextAlign.left,
        ),
        new Container(
          margin: new EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.black26),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))
          ),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: new TextField(
              controller: text,
              decoration: new InputDecoration(
                hintText: 'Type something',
              ),
            ),
          ),
        ),
        new Container(
          width: double.INFINITY,
          child: isChange == -1 ? new RaisedButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              textColor: Colors.black,
              child: new Text(
                "Добавить",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                debugPrint(label.text.toString() + " " + text.text.toString());
                if (label.text.length > 0 && text.text.length > 0) {
                  notes.add(
                      new Note(label.text.toString(), text.text.toString()));
                  debugPrint(notes[notes.length - 1].title);
                  label.clear();
                  text.clear();
                  _listChanged(notes);
                }
              })
              : new RaisedButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              textColor: Colors.black,
              child: new Text(
                "Изменить",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                _changeItem(isChange);
              }),
        ),
        notes.length > 0
            ? new ListNotes(
          notes: notes,
          onChanged: _listChanged,
          deleteItem: _deleteItem,
          changeItem: _setIsChange,
        )
            : new Row()
      ],
    );
  }
}

class ListNotes extends StatelessWidget {
  ListNotes(
      {Key key, this.notes, @required this.onChanged, @required this.deleteItem, @required this.changeItem})
      : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final List<Note> notes;
  final ValueChanged<List<Note>> onChanged;
  final ValueChanged<int> deleteItem;
  final ValueChanged<int> changeItem;

  @override
  Widget build(BuildContext context) {
    //debugPrint("length ${notes.length}");
    //return new Text(notes.length.toString());
    return new Flexible(child: new ListView.builder(
        itemCount: notes == null ? 0 : notes.length,
        itemBuilder: (context, int i) {
          if (notes == null && notes.length > 0)
            return new Container(
              width: 0.0,
              height: 0.0,
            );
          else
            return new Item(
              note: notes[i],
              position: i,
              deleteItem: deleteItem,
              changeItem: changeItem,);
        }));
  }
}

class Item extends StatelessWidget {
  Item(
      {this.note, this.position, @required this.deleteItem, @required this.changeItem});

  final _titleStyle = const TextStyle(fontSize: 18.0, color: Colors.black);
  final Note note;
  final int position;
  final ValueChanged<int> deleteItem;
  final ValueChanged<int> changeItem;

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.INFINITY,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: new BoxDecoration(
          //borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
            border: new Border.all(width: 2.0, color: Colors.black26),
            borderRadius: new BorderRadius.all(new Radius.circular(4.0))
        ),
        child:
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Column(children: <Widget>[
                    new Text(note.title, style: _titleStyle),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(note.text),
                    ),
                  ],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new IconButton(icon: new Icon(Icons.edit), onPressed: () {
                    changeItem(position);
                  },),
                  new IconButton(icon: new Icon(Icons.delete), onPressed: () {
                    deleteItem(position);
                  },)
                ],
              )
            ],)
          ),
        ));
  }
}
