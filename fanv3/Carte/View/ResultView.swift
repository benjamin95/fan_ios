//
//  ResultView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 13/01/2024.
//

import SwiftUI
import MapKit

struct ResultView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var selectedItem: String?
    @State private var showDetails = false
    @State private var client: ClientResult = ClientResult(location: .paris, nom: "Test", adresse: "Test")
    var places: [Place] = [Place]()
    
    let parisTestData = [
        Place(id: "1", name: "Tour Eiffel", coordinate: CLLocationCoordinate2D(latitude: 48.8584, longitude: 2.2945)),
        Place(id: "2", name: "Louvre", coordinate: CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376)),
        Place(id: "3", name: "Cathédrale Notre-Dame de Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8529, longitude: 2.3500)),
        Place(id: "4", name: "Sacré-Cœur", coordinate: CLLocationCoordinate2D(latitude: 48.8867, longitude: 2.3431)),
        Place(id: "5", name: "Arc de Triomphe", coordinate: CLLocationCoordinate2D(latitude: 48.8738, longitude: 2.2950))
    ]
    
    private var selectedPlace: Place? {
        if let selectedItem {
            return parisTestData.first(where: { $0.id.hashValue == selectedItem.hashValue })
        }
        return nil
    }
    
    
    var body: some View {
        VStack {
            
            Map(position: $cameraPosition, selection: $selectedItem) {
                ForEach(parisTestData, id: \.id) { place in
                        Marker(
                          place.name,
                          //monogram: place.icon, // ou autre propriété si disponible
                          coordinate: place.coordinate
                        ).tag(place.id)
                    }
            }
            
            .onChange(of: selectedItem, { oldValue, newValue in
                showDetails = newValue != nil
            })
            .sheet(isPresented: $showDetails, content: {
                //ClientCarteView(place: selectedPlace!)
            })
            
            .mapControls{
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
            }
//            .ignoresSafeArea()
            .navigationTitle("Clients a faire ce mois")
            
        }
    }
}

#Preview {
    ResultView()
}
