//
//  TextGeneratorView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 20/05/2024.
//

import SwiftUI

struct TextGeneratorView: View {
    
    private func insertKeyword(_ keyword: String) {
        // Ajouter le mot-clé avec un espace avant pour éviter les erreurs de concaténation
        note += " \(keyword)"
    }
    
    @Binding var note: String
    let keywords = noteInterventionOptions
    
    var body: some View {
        VStack {
            TextEditor(text: $note)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 100)
            
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    ForEach(keywords, id: \.self) { keyword in
                        Button(action: {
                            // Ajouter le mot-clé dans le TextEditor
                            insertKeyword(keyword)
                        }) {
                            Text(keyword)
                                .padding(6)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    @State var note = ""
    return TextGeneratorView(note: .constant(note))
}
