//
//  PedalListView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

struct Profile1View: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

public struct PedalListView: View {
    
    @ObservedObject var viewModel: PedalListViewModel
    
    
    init(viewModel: PedalListViewModel = PedalListViewModel()) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            
            Group {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .content:
                    contentView
                }
            }
           
            .sheet(isPresented: $viewModel.isShowingSheet) {
                CreatePedalView(delegate: viewModel)
            }
            
            .navigationTitle("Pedal List")
            .overlay(
                 Profile1View()
                     .padding(.trailing, -20)
                     .offset(x: 0, y: -50)
             , alignment: .topTrailing)
            
            
            .toolbar {
                
                // testing view
                Button {
                    viewModel.populatePedals()
                } label: {
                    Image(systemName: "eyes")
                }
                
                Button {
                    viewModel.addIconPressed()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    @ViewBuilder
    private var emptyView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("None pedals registered yet")
                    .font(.headline)
                
                Text("You may add new pedals by tapping in the superior button")
                    .font(.subheadline)
            }
            .foregroundStyle(.secondary)
            .font(.headline)
            .padding(.top, 200)
        }
       
    }
    
    @ViewBuilder
    private var contentView: some View {
        List(viewModel.filteredPedals, id: \.id) { pedal in
            VStack(alignment: .leading) {
                    Text(pedal.name)
                    .font(.subheadline)
                        .foregroundStyle(.primary)
                    
                    Text(pedal.brand)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                
             
                
                HStack {
                    ForEach(pedal.knobs, id: \.id) { knob in
                        Text(knob.parameter)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                         
                    }
           
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
               
        }
        
    }
    
}


struct PedalListView_Previews: PreviewProvider {
    static var previews: some View {
        PedalListView()
    }
}
