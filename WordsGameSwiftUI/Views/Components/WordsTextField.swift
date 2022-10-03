//
//  WordsTextField.swift
//  WordsGameSwiftUI
//
//  Created by Alexander Zub on 02.10.2022.
//

import SwiftUI

struct WordsTextField: View {
    @State var word: Binding<String>
    var placeholder: String
    var body: some View {
        
        TextField(placeholder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(12)
    }
}

