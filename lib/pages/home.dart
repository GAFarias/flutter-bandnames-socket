import 'dart:async';

import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'AC DC', votes: 4),
    Band(id: '3', name: 'Riff', votes: 6),
    Band(id: '4', name: 'La Renga', votes: 4),
    Band(id: '5', name: 'Kiss', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle( color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index)=> _bandTile(bands[index]),
       
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon (Icons.add),
        elevation: 1,
        onPressed: addnewBand),
   );
  }

  Widget _bandTile( Band banda) {
    return Dismissible(
          key: Key(banda.id) ,
          direction: DismissDirection.startToEnd,
          onDismissed: ( direction ) {
            //TODO: hacer el borrado
            print('Direccion $direction');
            print('id ${banda.id}');
          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Delete band')
              )
          ),
          child: ListTile(
          leading: CircleAvatar(
            child: Text(banda.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(banda.name),
          trailing: Text('${banda.votes}' , style: TextStyle(fontSize: 20),),
          onTap: () {
            print(banda.name);
          },
        ),
    );
  }

  addnewBand() {

    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: ( context ) {
        return AlertDialog(
          title: Text('Nombre de la nueva banda'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList( textController.text )
              )
          ],
        );
      }
      );
  }

  void addBandToList( String name ) {
    if ( name.length > 1 ) {
      this.bands.add(new Band(id:DateTime.now().toString(), name: name, votes: 0));
    }

    setState(() {
      
    });

    Navigator.pop(context);
  }
}