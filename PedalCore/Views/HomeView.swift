//
//  HomeView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var isShowingSheet: Bool = false
    
    public init() {
        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        NavigationView {
            List(viewModel.pedals, id: \.id) { pedal in
                Text(pedal.name)
            }
            
            .sheet(isPresented: $isShowingSheet) {
                CreatePedalView(delegate: viewModel)
            }
            
            .navigationTitle("Pedal List")
            
            .toolbar {
                Button {
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
