//
//  GameViewModel.swift
//  WordsGameSwiftUI
//
//  Created by Alexander Zub on 02.10.2022.
//

import Foundation

enum WordError: Error {
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
    case undefinedError
}


class GameViewModel: ObservableObject {
  
    // реактивное программирование @State и @Published(наблюдаемые свойства)
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    
    let word: String
    var isFirst = true
    
    init(player1: Player, player2: Player, word: String) {
        self.player1 = player1
        self.player2 = player2
        self.word = word
    }
    
    func validate(word: String) throws {
        let word = word.uppercased()
        guard word != self.word else {
            print("Думаешь самый умный? Составленное слово не должно быть исходным словом")
            throw WordError.theSameWord
        }
        guard !(words.contains(word)) else {
            print("Прояви фантазию! Придумай новое слово, не составленное ранее.")
            throw WordError.beforeWord
        }
        guard word.count > 1 else {
            print("Слишком короткое слово")
            throw WordError.littleWord
        }
        return
    }
    
    func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    
    func check(word: String) throws -> Int {
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var result = ""
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char { // чтобы убрать возможность пользоваться одним и тем же символом
                    i += 1
                }
                bigWordArray.remove(at: i)
            } else {
                throw WordError.wrongWord
            }
        }
        guard result == word.uppercased() else {
            print("Неизвестная ошибка")
            return 0
        }
        words.append(result)
        if isFirst {
            player1.score += result.count
        } else {
            player2.score += result.count
        }
        isFirst.toggle()
        return result.count
    }
}
