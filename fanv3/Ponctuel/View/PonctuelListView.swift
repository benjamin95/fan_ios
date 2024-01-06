//
//  PonctuelListView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 26/12/2023.
//

import SwiftUI

struct PonctuelListView: View {
    @StateObject var viewModel: PonctuelViewModel  = PonctuelViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State var fait: Bool = false
    
    var body: some View {
        NavigationStack{
            
            VStack {
                List (viewModel.ponctuels) { ponctuel in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            PonctuelDetail(ponctuel: ponctuel)
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(ponctuel.fait! ? .green : .red)
                            Text(ponctuel.nom ?? "Pas de nom")
                            
                        }
                        
                        
                    }
                }
                .listStyle(.plain)
                
                
            }
            
            
            
            .task {
                viewModel.getTachesNonFaites()
            }
            .navigationTitle("Liste des ponctuels")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    PonctuelListView()
}
