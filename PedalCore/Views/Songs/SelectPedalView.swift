//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: CreateSongViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.availablePedals.isEmpty {
                    emptyView
                } else {
                    pedalContentList
                }
            }
            .navigationTitle("Select a pedal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        dismiss()
                    }
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
                List(viewModel.availablePedals) { pedal in
                    Button {
                        viewModel.toggleSelection(for: pedal)
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
                            
                            if viewModel.pedalList.contains(pedal) {
                                if let index = viewModel.pedalList.firstIndex(where: {$0 == pedal}) {
                                    Image(systemName: "\(index + 1).square")
                                }
                            }
                        }
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
        SelectPedalView(viewModel: CreateSongViewModel())
    }
}
