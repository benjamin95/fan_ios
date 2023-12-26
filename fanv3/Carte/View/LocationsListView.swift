//
//  LocationsListView.swift
//  FAN
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject var vm: CarteViewModel
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                
                Button{
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
            
        }
        .listStyle(.plain)
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView().environmentObject(CarteViewModel())
    }
}

extension LocationsListView {
    
    func listRowView(location:Location) -> some View {
        HStack{
            VStack(alignment: .leading) {
                Text(location.nom!)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
