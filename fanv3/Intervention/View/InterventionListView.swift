//
//  InterventionListView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI


struct InterventionListView: View {
    
    @StateObject var viewModel = InterventionViewModel()
    
    var body: some View {
        NavigationStack{
            
            if viewModel.interventionsNom.isEmpty {
                
                ContentUnavailableView("Aucune intervention ce mois", systemImage: "nosign", description: Text("Pas d'intervention trouvé"))
            }
            else {
                    List(viewModel.interventionsNom) { intervention in
//                        NavigationLink (destination: InterventionDetailView(intervention: intervention))  {
                        
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(String(intervention.client!))
                                    Spacer()
                                    Text(convertStringToDate(intervention.date!, format: "yyyy-MM-dd")!, style: .date)
                                        .font(.subheadline)
                                        .padding(3)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .font(.caption)
                                        .overlay(
                                                  RoundedRectangle(cornerRadius: 5)
                                                        .stroke(Color.gray, lineWidth: 2)
                                                        )
                                                        .cornerRadius(5)
                                                        
                                }
                                
//                                Text(intervention.note!)
//                                    .padding(.top, 10)
                                
                                
                                
                            }
                        }
//                    }
                    .listStyle(.plain)
              
                
                
                .navigationTitle("\(viewModel.interventionsNom.count) Interventions ce mois")
                
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
                }
            }
            
        }
        .task {
            viewModel.getInterventionsNomParMois()
        }
    }
}

struct InterventionListView_Previews: PreviewProvider {
    static var previews: some View {
        InterventionListView()
    }
}
