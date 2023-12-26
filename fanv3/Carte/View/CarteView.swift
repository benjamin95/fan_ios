//
//  CarteView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 23/08/2023.
//

import SwiftUI
import MapKit


struct CarteView: View {
    @EnvironmentObject var vm: CarteViewModel 
    
    var body: some View {
        ZStack {

            mapLayer
            .ignoresSafeArea()
            VStack(spacing: 0){
                
                header
                    .padding()
                Spacer()
                
                ZStack{
                    ForEach(vm.locations){ location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .padding()
                                .shadow(radius: 20)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                        
                    }
                }
            }
            
        }
        
    }
}

struct CarteView_Previews: PreviewProvider {
    static var previews: some View {
        CarteView().environmentObject(CarteViewModel())
    }
}

extension CarteView {
    
    private var header : some View {
        VStack {
            Button(action: vm.toggleLocationList) {
                Text(vm.mapLocation.nom!)
                    .font(.caption)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationmapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
}
