//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var allPedals: [Pedal.Model]
    @State var selectedPedals: [Pedal.Model]
    @State var searchText: String = ""
    var onDismiss: ([Pedal.Model]) -> Void
    
    init(allPedals: [Pedal.Model], selectedPedals: [Pedal.Model],
         onDismiss: @escaping ([Pedal.Model]) -> Void) {
        self._allPedals = State(initialValue: allPedals)
        self._selectedPedals = State(initialValue: selectedPedals)
        self.onDismiss = onDismiss
    }
    
    
    public var filteredPedals: [Pedal.Model] {
        if searchText.isEmpty {
            return allPedals
        } else {
            return allPedals.filter { pedal in
                pedal.name.localizedCaseInsensitiveContains(searchText) || pedal.brand.localizedCaseInsensitiveContains(searchText) ||
                allPedals.contains(pedal)
            }
        }
    }
    
    private func toggleSelection(for pedal: Pedal.Model) {
        if selectedPedals.contains(pedal) {
            selectedPedals.removeAll(where: {$0 == pedal})
        } else {
            selectedPedals.append(pedal)
        }
    }
    
    public func shouldBeIndicatedWithLight(for pedal: Pedal.Model) -> Bool {
        return selectedPedals.contains(pedal)
    }
    
    var body: some View {
        Group {
            if allPedals.isEmpty {
                emptyView
            } else {
                pedalContentList
            }
        }
        .onDisappear {
            onDismiss(selectedPedals)
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
                    ForEach(filteredPedals, id: \.signature) { pedal in
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
        SelectPedalView(allPedals: Pedal.pedalSample(), selectedPedals: []) { _ in
            
        }
    }
}
