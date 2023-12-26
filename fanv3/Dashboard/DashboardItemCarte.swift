//
//  DashboardItemCarte.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 23/08/2023.
//

import SwiftUI

struct DashboardItemCarte: View {
    @StateObject var viewModel: InterventionViewModel = InterventionViewModel()
    
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        Text("Carte des clients")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "map")
                            .foregroundColor(Color.blue)
                            .font(.largeTitle)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(Color("Overlay"))
        .cornerRadius(15)
    }
}

struct DashboardItemCarte_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemCarte()
    }
}
