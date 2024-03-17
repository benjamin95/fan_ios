//
//  CarteViewAfaire.swift
//  fanv3
//
//  Created by Benjamin Truillet on 07/01/2024.
//

import SwiftUI
import MapKit

struct CarteViewAfaire: View {
    
    @StateObject var viewModel: CarteViewModel = CarteViewModel()
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var mapSelection: String?
    @State private var showDetails = false
    
    private var selectedPlace: Location? {
        if let mapSelection {
            return viewModel.locations.first(where: { $0.id.hashValue == mapSelection.hashValue })
        }
        return nil
    }
    
    var body: some View {
        VStack {
            
            Map(position: $cameraPosition, selection: $mapSelection) {
                ForEach(viewModel.locations) { result in
                    Marker(result.nom!, systemImage: "mappin.circle" , coordinate: result.coordinates)
                        .tint(.red)
                }
            }
            .onChange(of: mapSelection, { oldValue, newValue in
                showDetails = newValue != nil
            })
            .sheet(isPresented: $showDetails, content: {
                ClientCarteView(location: selectedPlace!, show: $showDetails)
                    .presentationDetents([.height(200)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                    .presentationCornerRadius(12)
            })
            
            .mapControls{
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
            }
//            .ignoresSafeArea()
            .navigationTitle("Clients a faire ce mois")
            .task {
                viewModel.getClients()
            }
        }
        
    }
        
}

#Preview {
    CarteViewAfaire()
}


extension CLLocationCoordinate2D {
    static var paris: CLLocationCoordinate2D {
        return .init(latitude: 48.8534, longitude: 2.3488)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .paris, 
                     latitudinalMeters: 10000,
                     longitudinalMeters: 10000)
    }
}
