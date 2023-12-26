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
            
            VStack {
                List(viewModel.interventions) { intervention in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            //
                        } label: {
                            Text(convertStringToDate(intervention.date!, format: "yyyy-MM-dd")!, style: .date)
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .task {
                viewModel.getInterventionsParMois()
            }
            
            .navigationTitle("Liste Des \(viewModel.interventions.count) Interventions")
            
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
            }
            
        }
    }
}

struct InterventionListView_Previews: PreviewProvider {
    static var previews: some View {
        InterventionListView()
    }
}
