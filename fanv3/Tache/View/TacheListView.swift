//
//  TacheListView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import SwiftUI

struct TacheListView: View {
    
    @StateObject var viewModel: TacheViewModel  = TacheViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State var fait: Bool = false
    
    var body: some View {
        NavigationStack{
            
            if viewModel.taches.isEmpty {
                
                ContentUnavailableView("Pas de réinterventions a faire", systemImage: "nosign", description: Text("Aucun client trouvé"))
            }
            else {
                
                VStack {
                    List (viewModel.taches) { tache in
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            
                            
                            HStack {
                                NavigationLink {
                                    ClientDetail2(client: tache.client!)
                                } label: {
                                    Text(tache.client!.nom ?? "Inconnu")
                                }
                                
                                tache.fait! ? Text("Fait le \(formatDateInFrench(dateString: tache.faitLe ?? "" ) ?? "Pas de date") ") : Text("")
                            }
                            Label {
                                Text(tache.tache!)
                            } icon: {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(tache.fait! ? .green : .red) // Remplacez .red par la couleur de votre choix
                            }
                        }
                        .swipeActions(edge: .leading) {
                                                Button(action: {
                                                    viewModel.editTache(tache: tache, fait: false)
                                                    presentationMode.wrappedValue.dismiss()
                                                }) {
                                                    Image(systemName: "trash")
                                                }
                                                .tint(.red)
                                            }
                        .swipeActions {
                            
                            Button(action: {
                                viewModel.editTache(tache: tache)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "checkmark")
                            }
                            .tint(.green)
                        }
                    }
                    .listStyle(.grouped)
                    
                    
                }
                
                
                
                
            }
            
            
        }
        .task {
            viewModel.getTaches()
        }
        .navigationTitle("Réinterventions")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct TacheAFaire : View {
    var body: some View {
        Text("A faire")
    }
}

struct TacheListView_Previews: PreviewProvider {
    static var previews: some View {
        TacheListView()
    }
}
