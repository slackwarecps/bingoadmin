
import 'package:bingoadmin/models/sorteio.dart';
import 'package:flutter/material.dart';


// LISTA DE JOGADORES - UNICA FONTE DE VERDADE
// escuta as mudanças e notifica os listeners
// ideia do singleton
class Sorteios extends ChangeNotifier{
    List<Sorteio> sorteios = [];


    // Construtor
    Sorteios({
      required this.sorteios
    });

    // Adiciona um jogador
    void addSorteio(Sorteio sorteio){
      sorteios.add(sorteio);

      // Notifica os listeners
      notifyListeners();
    }

    void remove(int index) {
      sorteios.removeAt(index);
      notifyListeners();
    }


  void setSorteios(List<Sorteio> sorteios) {
    this.sorteios = sorteios;
    notifyListeners();
  }





}