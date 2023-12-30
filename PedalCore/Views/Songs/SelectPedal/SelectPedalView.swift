//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

protocol SelectPedalDelegate: AnyObject {
    func didFinishSelectingPedals(_ pedals: [Pedal])
    
}

class SelectPedalViewModel: ObservableObject {
    @Published var availablePedals: [Pedal] = []
    @Published var selectedPedals: [Pedal] = []
    @Published var searchText: String = ""
    
    weak var delegate: SelectPedalDelegate?
    var pedalProvider: LocalDataProvider<Pedal>
    
    init(selectedPedals: [Pedal], delegate: SelectPedalDelegate?) {
        let pedalPersistence = JsonDataService<Pedal>(fileName: "Pedal")
        self.pedalProvider =  LocalDataProvider<Pedal>(persistence: pedalPersistence)
        try? self.pedalProvider.load { pedals in
            self.availablePedals = pedals
        }
        
        self.selectedPedals = selectedPedals
        self.delegate = delegate
    }
    
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
    
    public func toggleSelection(for pedal: Pedal) {
        if selectedPedals.contains(pedal) {
            selectedPedals.removeAll(where: {$0 == pedal})
        } else {
            selectedPedals.append(pedal)
        }
    }
    
    public func shouldBeIndicatedWithLight(for pedal: Pedal) -> Bool {
        return selectedPedals.contains(pedal)
    }
    
    public func viewWillDisappear() {
        delegate?.didFinishSelectingPedals(self.selectedPedals)
    }
    
}

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: SelectPedalViewModel
    
    init(viewModel: SelectPedalViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        Group {
            if viewModel.availablePedals.isEmpty {
                emptyView
            } else {
                pedalContentList
            }
        }
        .onDisappear {
            viewModel.viewWillDisappear()
        }
        .navigationTitle("Select pedals")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    viewModel.viewWillDisappear()
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
                    ForEach(viewModel.filteredPedals, id: \.signature) { pedal in
                        Button {
                            withAnimation {
                                viewModel.toggleSelection(for: pedal)
                            }
                            
                        } label: {
                            SelectPedalRow(pedal: pedal,
                                           isOn: viewModel.shouldBeIndicatedWithLight(for: pedal))
                            .padding(.vertical, 4)
                        }
                    }
                }
                .searchable(text: $viewModel.searchText)
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
        SelectPedalView(viewModel: SelectPedalViewModel(selectedPedals: [], delegate: nil))
    }
}
