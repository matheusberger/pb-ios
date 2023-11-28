//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var availablePedals: [Pedal] = Pedal.pedalSample()
    @State var pedalList: [Pedal]
    
    var onDismiss: ([Pedal]) -> Void
    @State var searchText: String = ""
    
    public var filteredPedals: [Pedal] {
        if searchText.isEmpty {
            return availablePedals
        } else {
            return availablePedals.filter { pedal in
                pedal.name.localizedCaseInsensitiveContains(searchText) || pedal.brand.localizedCaseInsensitiveContains(searchText) ||
                availablePedals.contains(pedal)
            }
        }
    }
    
    private func toggleSelection(for pedal: Pedal) {
        if pedalList.contains(pedal) {
            pedalList.removeAll(where: {$0 == pedal})
        } else {
            pedalList.append(pedal)
        }
    }
    
    public func shouldBeIndicatedWithLight(for pedal: Pedal) -> Bool {
        return pedalList.contains(pedal)
    }
    
    var body: some View {
            Group {
                if availablePedals.isEmpty {
                    emptyView
                } else {
                    pedalContentList
                }
            }
            .onDisappear {
                onDismiss(pedalList)
            }
            .navigationTitle("Select pedals")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
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
                List {
                    ForEach(filteredPedals, id: \.self) { pedal in
                        Button {
                            withAnimation {
                               toggleSelection(for: pedal)
                            }
                            
                        } label: {
                            SelectPedalRow(pedal: pedal,
                                           isOn: shouldBeIndicatedWithLight(for: pedal))
                            .padding(.vertical, 4)
                        }
                    }
                }
                .searchable(text: $searchText)
                .buttonStyle(.plain)
                
            }
        header: {
            Text("Your PedalBoard")
        } footer: {
            Text("You can add new pedals on pedal List view")
        }
        }
    }
}


struct SelectPedalView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPedalView(pedalList: Pedal.pedalSample()) { _ in
            
        }
    }
}
