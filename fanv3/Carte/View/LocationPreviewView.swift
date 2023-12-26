//
//  LocationPreviewView.swift
//  FAN
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm: CarteViewModel
    let location: Location
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(location.nom!)
                .font(.callout)
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: {
                vm.nextButtonPressed()
            }) {
                Text("Suivant")
                    .padding()
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary, lineWidth: 1)
                    )
                    .shadow(radius: 50)
            }
        }
        .padding()
        .frame(maxWidth: .infinity) // Pour étendre le VStack sur toute la largeur de l'écran
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        }// Couleur de fond claire
        .edgesIgnoringSafeArea(.all) // Ignorer les zones sécurisées pour étendre le fond sur toute la surface
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        let location = Location(nom: "UPEP Clichy", adresse: "Test", ville: "Clicky", codePostal: 92340, telFixe: "67676", telPortable: "78767", contact: "MR COGEZ", lat: 48.866667, lng: 2.333333)
        LocationPreviewView(location: location).environmentObject(CarteViewModel())
    }
}


extension LocationPreviewView {
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(location.nom!)
                .font(.caption)
                .fontWeight(.bold)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Suivant")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.bordered)
    }
}
