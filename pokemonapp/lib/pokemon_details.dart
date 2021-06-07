import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemonapp/models/pokemon.dart';

class PokemonDetaylar extends StatefulWidget {

  Pokemon pokemon;
  PokemonDetaylar({this.pokemon});

  @override
  _PokemonDetaylarState createState() => _PokemonDetaylarState();
}

class _PokemonDetaylarState extends State<PokemonDetaylar> {

  Color baskinRenk;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {

    baskinRengiBul();
    super.initState();
  }

  void baskinRengiBul(){
    Future<PaletteGenerator> fPaletteGenerator= PaletteGenerator.fromImageProvider(
        NetworkImage(widget.pokemon.img));

    fPaletteGenerator.then((value) {
      paletteGenerator = value;
      debugPrint("secilen renk : " +paletteGenerator.dominantColor.color.toString());

      setState(() {

        baskinRenk =paletteGenerator.dominantColor.color;
      });

    } );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(widget.pokemon.name),),
      body: OrientationBuilder(builder: (context,orientation) {
        if(orientation == Orientation.portrait){
          return dikeyBody(context);
        }
        else{
          return yatayBody(context);
        }
      },),
    );
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (7/10),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 70),
                Text(widget.pokemon.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text("Height: " +widget.pokemon.height),
                Text("Weight: " +widget.pokemon.weight),
                Text("Types: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type.map((tip) => Chip(
                    backgroundColor: baskinRenk,
                    label: Text(tip,style: TextStyle(color: Colors.white),
                    ))).toList(),
                ),
                Text("Pre Evolution: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null ? widget.pokemon.prevEvolution.map((preevolution) => Chip(
                      backgroundColor: baskinRenk,
                      label: Text(preevolution.name,style: TextStyle(color: Colors.white),
                      ))).toList() : [Text("İlk hali")],
                ),
                Text("Next Evolution: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null ? widget.pokemon.nextEvolution.map((nextevolution) => Chip(
                      backgroundColor: baskinRenk,
                      label: Text(nextevolution.name,style: TextStyle(color: Colors.white),
                      ))).toList() : [Text("Son hali")],
                ),
                Text("Weakness: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null ? widget.pokemon.weaknesses.map((weakness) => Chip(
                      backgroundColor: baskinRenk,
                      label: Text(weakness,style: TextStyle(color: Colors.white),
                      ))).toList() : [Text("Son hali")],
                ),
              ],
            ),
        ),),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(widget.pokemon.img,fit: BoxFit.contain,),
            ),
          ),
        )
      ],
    );
  }

  Widget yatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-30,
        height: MediaQuery.of(context).size.height*(3/4),
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: widget.pokemon.img,
                child: Container(
                  width: 200,
                  child: Image.network(widget.pokemon.img,fit: BoxFit.fill,),
                ),
              ),
            ),
            Expanded(
              flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 70),
                      Text(widget.pokemon.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      Text("Height: " +widget.pokemon.height),
                      Text("Weight: " +widget.pokemon.weight),
                      Text("Types: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.pokemon.type.map((tip) => Chip(
                            backgroundColor: Colors.deepOrange,
                            label: Text(tip,style: TextStyle(color: Colors.white),
                            ))).toList(),
                      ),
                      Text("Pre Evolution: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.pokemon.prevEvolution != null ? widget.pokemon.prevEvolution.map((preevolution) => Chip(
                            backgroundColor: Colors.deepOrange,
                            label: Text(preevolution.name,style: TextStyle(color: Colors.white),
                            ))).toList() : [Text("İlk hali")],
                      ),
                      Text("Next Evolution: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.pokemon.nextEvolution != null ? widget.pokemon.nextEvolution.map((nextevolution) => Chip(
                            backgroundColor: Colors.deepOrange,
                            label: Text(nextevolution.name,style: TextStyle(color: Colors.white),
                            ))).toList() : [Text("Son hali")],
                      ),
                      Text("Weakness: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.pokemon.weaknesses != null ? widget.pokemon.weaknesses.map((weakness) => Chip(
                            backgroundColor: Colors.deepOrange,
                            label: Text(weakness,style: TextStyle(color: Colors.white),
                            ))).toList() : [Text("Son hali")],
                      ),
                    ],
                  ),
                ),),
          ],
        ),
    );
  }
}

