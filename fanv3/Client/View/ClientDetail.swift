//
//  ClientDetail.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 19/08/2023.
//

import SwiftUI

func convertStringToDate(_ dateString: String, format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "fr_FR")
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: dateString)
}

struct ClientDetail: View {
    
    
    var client: Client
    @State private var isSheetPresented = false
    
    var body: some View {
        
        //        let latitude: Double = Double(client.lat!)!
        //        let longitude: Double = Double(client.lng!)!
        //
        //        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude:longitude)
        
        
        
        
        NavigationStack {
            VStack(alignment: .center) {
                
                //                MapView(coordinate: coordinate, titre: client.nom ?? "Pas de nom")
                //                .ignoresSafeArea(edges: .top)
                //                .frame(height: 200)
                Group {
                    
                    HStack {
                        Text("Téléphone : ")
                        Spacer()
                        //
                        Button {
                            print("Clicked")
                            
                        } label: {
                            Image(systemName: "phone")
                            Link(client.telFixe ?? "", destination: URL(string: "tel:\(String(describing: client.telFixe!))")!)
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.caption)
                        
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    
                    HStack {
                        Text("Adresse : ")
                        Spacer()
                        Text(client.adresse ?? "Inconnue")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        Text("Contact : ")
                        Spacer()
                        Text(client.contact ?? "Inconnu")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        
                        Text("Derniére Inter : ")
                        Spacer()
                        Text(convertStringToDate(client.derniereInter!, format: "yyyy-MM-dd")!, style: .date)
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        
                        Text("Prochaine Inter : ")
                        Spacer()
                        Text(convertStringToDate(client.prochaineInter!, format: "yyyy-MM-dd")!, style: .date)
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        
                        Text("Statut : ")
                        Spacer()
                        Text(client.statutMagasin ?? "Inconnu")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        
                        Text("Prestation : ")
                        Spacer()
                        Text(client.prestation ?? "Inconnu")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    HStack {
                        
                        Text("Délai : ")
                        Spacer()
                        Text("\(client.delaiProchaineInter ?? 90) Jours")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    .padding(5)
                    
                    
                    
                }
                Spacer()
                
            }
            .navigationTitle(client.nom!)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                        Button(action: {isSheetPresented = true}, label: {
                            Label("Home", systemImage: "folder.badge.plus").foregroundColor(Color.primary)
                            
                        })
                        .sheet(isPresented: $isSheetPresented) {
                            InterventionAjoutView(client: client, isPresented: $isSheetPresented)
                            
                        }
                        
                    
                }
            }
        }
        
    }
}

struct ClientDetail_Previews: PreviewProvider {
    static var previews: some View {
        let intervention = Intervention(date: "TEst", note: "TEst", typeIntervention: "TEst", technicien: 3, client: 1, id: 1)
        
        let client = Client(
            id: 574,
                nom: "A2PAS CHEVREAU 20EME",
                adresse: "40 Rue Henri Chevreau, 75020 Paris, France",
                ville: "Paris",
                codePostal: 75020,
                telFixe: "01 43 66 72 50",
                telPortable: nil, // Vous pouvez laisser nil si le numéro de portable est null
                contact: "Mr COGEZ",
                derniereInter: "2023-08-14",
                statutMagasin: "Régulé",
                prestation: "RT + DS Blattes",
                delaiProchaineInter: 90,
                prochaineInter: "2023-11-14",
                lat: "48.8705651",
                lng: "2.3886057",
                interventions: [intervention]
                )
        ClientDetail(client: client)
    }
}
