import 'package:bingoadmin/models/jogador.dart';
import 'package:flutter/material.dart';


// LISTA DE JOGADORES - UNICA FONTE DE VERDADE
// escuta as mudanças e notifica os listeners
// ideia do singleton
class Jogadores extends ChangeNotifier{
    List<Jogador> jogadores = [];


    // Construtor
    Jogadores({
      required this.jogadores
    });

    // Adiciona um jogador
    void addJogador(Jogador jogador){
      jogadores.add(jogador);

      // Notifica os listeners
      notifyListeners();
    }

  void setJogadores(List<Jogador> jogadores) {
    this.jogadores = jogadores;
    notifyListeners();
  }



}