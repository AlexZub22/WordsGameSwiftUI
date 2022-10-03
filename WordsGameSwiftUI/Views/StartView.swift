//
//  ContentView.swift
//  WordsGameSwiftUI
//
//  Created by Alexander Zub on 02.10.2022.
//

import SwiftUI

struct StartView: View {
    @State var bigWord = "" //State состояние
    @State var player1 = ""
    @State var player2 = ""
    @State var isShowedGame = false // Показан ли экран игры?
    @State var isAlertPresented = false
    
    
    var body: some View {
        
        
        VStack {
         
            TitleText(text: "WordsGame")
            
            WordsTextField(word: $bigWord, placeholder: "Введите большое слово")
                .padding(20) //по умолчанию со всех сторон на 16 поинтов
                .padding(.top, 32)
            WordsTextField(word: $player1, placeholder: "Игрок 1")
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
            WordsTextField(word: $player2, placeholder: "Игрок 2")
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
            Button {
                //action of button
                if bigWord.count > 7 {
                    isShowedGame.toggle()
                } else {
                    self.isAlertPresented.toggle()
                }
            } label: { // label of button
                Text("Старт")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(100)
                    .padding(.top)
            }
        }.background(Image("background"))
            .alert("Большое слово слишком короткое", isPresented: $isAlertPresented, actions: {
                Text("Ок!")
            })
            .fullScreenCover(isPresented: $isShowedGame) {
                
                let name1 = player1 == "" ? "Игрок 1" : player1
                let name2 = player2 == "" ? "Игрок 2" : player2
                
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)
               GameView(viewModel: gameViewModel)
            }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
