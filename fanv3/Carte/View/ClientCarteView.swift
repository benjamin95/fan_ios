//
//  ClientCarteView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 12/01/2024.
//

import SwiftUI
import MapKit

struct ClientCarteView: View {
    var location: Location = Location(nom: "APAS", adresse: "12 rue des vignes", ville: "PARIS", codePostal: 75015, telFixe: "06 78 45 12 12", telPortable: "06 45 41 21 21", contact: "MR COGEZ", lat: 12.121, lng: 1254.23)
    
    @Binding var show:Bool
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(location.nom ?? "Pas de nom" )
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(location.adresse ?? "Pas de nom" )
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                    Text(location.telFixe ?? "Pas de numero" )
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                    
                }
                
                Spacer()
                
                Button {
                    show.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            .padding()
            Spacer()
            
            HStack(spacing:24) {
                Button {
                    openInWaze(latitude: location.lat!, longitude: location.lng!)
                } label: {
                    Text("Ouvrir dans Waze")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 170, height: 48)
                        .background(.blue)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    callClient(phoneNumber: location.telFixe!)
                        }) {
                            HStack {
                                Image(systemName: "phone.fill") // Icône de téléphone
                                    .foregroundColor(.white) // Couleur de l'icône

                                Text("Appeler le client")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .frame(width: 170, height: 48)
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                    

            }
            .padding()
            
        }
    }
}

#Preview {
    ClientCarteView(show: .constant(false))
}
