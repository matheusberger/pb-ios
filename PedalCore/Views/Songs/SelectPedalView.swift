//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    var allUserPedals: [Pedal]
    @Binding var selectedPedals: [Pedal]
    
    
    func toggleSelection(for pedal: Pedal) {
           if selectedPedals.contains(pedal) {
               selectedPedals.removeAll(where: {$0 == pedal})
           } else {
               selectedPedals.append(pedal)
           }
       }
    
    #warning("Create a empty state if user has no pedals")
    var body: some View {
        Form {
            Section {
                List(allUserPedals) { pedal in
                    Button {
                        toggleSelection(for: pedal)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pedal.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Text(pedal.brand)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            if selectedPedals.contains(pedal) {
                                Image(systemName: "arrow.down.square")
                            }
                        }
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

struct SelectPedalView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPedalView(allUserPedals: Pedal.pedalSample(), selectedPedals: .constant([]))
    }
}
