import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/models/pokemon.dart';

class PokemonListele extends StatefulWidget {
  @override
  _PokemonListeleState createState() => _PokemonListeleState();
}

class _PokemonListeleState extends State<PokemonListele> {
  Uri url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  Welcome pokemon;
  Future<Welcome> veri;

  Future<Welcome> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokemon = Welcome.fromJson(decodedJson);
    return pokemon;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri=pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: FutureBuilder(future: veri, builder: (context, AsyncSnapshot<Welcome> gelenPokemon) {
        if(gelenPokemon.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(gelenPokemon.connectionState == ConnectionState.done) {
        /*  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
            itemBuilder: (context,index) {
             return InkWell(
              onTap: () {},
              child: Hero(tag: gelenPokemon.data.pokemon[index].img,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: "http://www.serebii.net/pokemongo/pokemon/index.png"),
                        ),
                        Text(gelenPokemon.data.pokemon[index].name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )),
            );
            });*/

          return GridView.count(crossAxisCount: 2,children: gelenPokemon.data.pokemon.map((poke) {
            return InkWell(
              onTap: () {},
              child: Hero(tag: poke.img,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: "http://www.serebii.net/pokemongo/pokemon/001.png"),
                        ),
                        Text(poke.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )),
            );
          }).toList(),);
        }
      }),
    );
  }
}
