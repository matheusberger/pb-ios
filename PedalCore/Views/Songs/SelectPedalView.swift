//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    // this should be a binding of CreateSongViewModel.pedalList
    // dismiss bug when first pedal was selected
    // switched to State and return value to be updated
    // investigate later with Berguer
    
    @State var selectedPedals: [Pedal]
    var allUserPedals: [Pedal] = Pedal.pedalSample()
    var onDismiss: ([Pedal]) -> Void
    
    
    func toggleSelection(for pedal: Pedal) {
           if selectedPedals.contains(pedal) {
               selectedPedals.removeAll(where: {$0 == pedal})
           } else {
               selectedPedals.append(pedal)
           }
       }
    
    var body: some View {
        Group {
            if allUserPedals.isEmpty {
                emptyView
            } else {
                pedalContentList
            }
        }
        .navigationTitle("Select a pedal")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    onDismiss(selectedPedals)
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            
            Text("None pedals registered yet")
                .font(.headline)

                .font(.subheadline)
            
            Spacer()
        }
        .foregroundStyle(.secondary)
        .font(.headline)
    }
    
    @ViewBuilder
    private var pedalContentList: some View {
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
                        .background(Color.green)
                    }
                    .buttonStyle(.plain)
                }
            } header: {
                Text("Your PedalBoard")
            } footer: {
                Text("You can add new pedals on pedal List view")
            }
        }
    }
}

struct SelectPedalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectPedalView(selectedPedals: []) { _ in
                
            }
        }
    }
}
