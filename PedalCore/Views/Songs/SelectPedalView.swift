//
//  SelectPedalView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SelectPedalView: View {
    @Environment(\.dismiss) var dismiss
      
      var pedals: [Pedal]
      
      var didSelect: (Pedal) -> Void
      
      var body: some View {
          Form {
              Section {
                  List(pedals) { pedal in
                      Button {
                             didSelect(pedal)
                             dismiss()
                      } label: {
                             Text(pedal.name)
                                 
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
        SelectPedalView(pedals: Pedal.pedalSample(), didSelect: { pedal in print("\(pedal) selected")})
    }
}
