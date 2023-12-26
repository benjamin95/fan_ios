//
//  DashboardInterventionsMois.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct DashboardInterventionsMois: View {
    @StateObject var viewModel: InterventionViewModel = InterventionViewModel()
    
    @State var nbr: String = "0"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var moisEnCours = ""
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        Text("\(viewModel.interventions.count) Interventions en \(moisEnCours) ")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "figure.walk.circle")
                            .foregroundColor(Color.green)
                            .font(.largeTitle)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(Color("Overlay"))
        .cornerRadius(15)
        .task{
            viewModel.getInterventionsParMois()
            let currentDate = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM YYYY"
            moisEnCours = dateFormatter.string(from: currentDate)
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }

}

struct DashboardInterventionsMois_Previews: PreviewProvider {
    static var previews: some View {
        DashboardInterventionsMois()
    }
}
