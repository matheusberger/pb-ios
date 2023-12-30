//
//  PedalListView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

extension Pedal.List {
    struct View: SwiftUI.View {
        
        @Environment(\.colorScheme) var colorScheme
        @StateObject var viewModel: ViewModel
        
        init(viewModel: ViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
            // Large Navigation Title
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
            // Inline Navigation Title
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        }
        
        public var body: some SwiftUI.View {
            VStack {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .content:
                    contentView
                }
                
                footerButtonsView
            }
            .navigationTitle("Pedal List")
            .padding(.bottom, 20)
            .sheet(isPresented: $viewModel.isShowingSheet, onDismiss: {
                viewModel.sheetDidDismiss()
            }) {
                if let pedal = viewModel.editPedal {
                    Pedal.Creation.View(viewModel: Pedal.Creation.ViewModel(delegate: self.viewModel, editPedal: pedal))
                } else {
                    Pedal.Creation.View(viewModel: Pedal.Creation.ViewModel(delegate: self.viewModel))
                }
            }
        }
        
        @ViewBuilder
        private var emptyView: some SwiftUI.View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                
                Text("None pedals registered yet")
                    .font(.headline)
                
                Text("You may add new pedals by tapping in the superior button")
                    .font(.subheadline)
                
                Spacer()
            }
            .foregroundStyle(.secondary)
            .font(.headline)
        }
        
        @ViewBuilder
        private var contentView: some SwiftUI.View {
            List(viewModel.filteredPedals, id: \.signature) { pedal in
                Row(pedal: pedal)
                
                    .contextMenu(menuItems: {
                        Button {
                            viewModel.editPedalPressed(pedal)
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(role: .destructive) {
                            viewModel.removePedalPressed(pedal)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    })
                
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.editPedalPressed(pedal)
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(Color("ExtraElementsColor"))
                        
                        
                        Button(role: .destructive) {
                            viewModel.removePedalPressed(pedal)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
        }
        
        private var footerButtonsView: some SwiftUI.View {
            VStack {
                Button {
                    viewModel.addIconPressed()
                } label: {
                    Text("Create new pedal")
                        .fontWeight(.bold)
                        .frame(width: 250,height: 30)
                    
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

struct PedalListView_Previews: PreviewProvider {
    static var previews: some View {
        let persistence = JsonDataService<Pedal.Model>(fileName: "PedalPreview")
        let provider =  LocalDataProvider<Pedal.Model>(persistence: persistence)
        let viewModel = Pedal.List.ViewModel(provider: provider)
        NavigationStack {
            Pedal.List.View(viewModel: viewModel)
        }
    }
}
