//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    var pedals: [Pedal]
    
    var didSelect: (Pedal) -> Void
    
    var body: some View {
        Form {
            Section {
                List(pedals) { pedal in
                    Button {
                           didSelect(pedal)
                           dismiss()
                    } label: {
                           Text(pedal.name)
                               
                       }
                       .foregroundStyle(.primary)
                    
                }
            } header: {
                Text("Your PedalBoard")
            } footer: {
                Text("You can add new pedals on pedal List view")
            }
            .navigationTitle("Select a pedal")
        }
        
    }
}

#Preview {
    SelectPedalView(pedals: Pedal.getFamousPedals()) { selectedPedal in
        print("tapped on \(selectedPedal.name)")
    }
}
