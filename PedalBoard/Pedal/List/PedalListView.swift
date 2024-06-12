//
//  PedalListView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI
import PedalCore

extension Pedal {
    struct ListView: View {
        @Environment(\.colorScheme) var colorScheme
        @EnvironmentObject private var navigationModel: NavigationModel
        @StateObject var viewModel: ListViewModel
        
        init(viewModel: ListViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
            // Large Navigation Title
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
            // Inline Navigation Title
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        }
        
        public var body: some View {
            VStack {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .content:
                    contentView
                }
                
                footerButtonsView
            }
            .onAppear {
                viewModel.setNavigationModel(navigationModel)
            }
            .navigationTitle("Pedal List")
            .padding(.bottom, 20)
        }
        
        @ViewBuilder
        private var emptyView: some View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                
                Text("No pedals registered yet")
                    .font(.headline)
                
                Text("You may add new pedals by tapping NEW PEDAL")
                    .font(.subheadline)
                
                Spacer()
            }
            .foregroundStyle(.secondary)
            .font(.headline)
        }
        
        @ViewBuilder
        private var contentView: some View {
            List(viewModel.filteredPedals, id: \.signature) { pedal in
                NavigationLink(value: viewModel.editViewModel(pedal)) {
                    ListRow(pedal: pedal)
                }
                .contextMenu(menuItems: {
                    Button(role: .destructive) {
                        viewModel.removePedalPressed(pedal)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                })
                
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.removePedalPressed(pedal)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
        }
        
        private var footerButtonsView: some View {
            NavigationLink(value: viewModel.editViewModel) {
                Text("NEW PEDAL")
                    .fontWeight(.bold)
                    .frame(width: 250,height: 30)
                    .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
    }
}

struct PedalListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Pedal.ListViewModel(provider: PreviewDataProvider())
        NavigationStack {
            Pedal.ListView(viewModel: viewModel)
        }
    }
}
