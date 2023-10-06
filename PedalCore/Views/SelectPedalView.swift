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
                    /*@START_MENU_TOKEN@*/Text(pedal.name)/*@END_MENU_TOKEN@*/
                        .onTapGesture {
                            didSelect(pedal)
                            dismiss()
                        }
                        .navigationTitle("Select a pedal")
                }
            } header: {
                Text("Your PedalBoard")
            } footer: {
                Text("You can add new pedals on pedal List view")
            }
            
        }

    }
}

#Preview {
    SelectPedalView(pedals: Pedal.getFamousPedals()) { selectedPedal in
        print("tapped on \(selectedPedal.name)")
    }
}
