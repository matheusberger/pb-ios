//
//  Teste.swift
//  PedalCore
//
//  Created by Lucas Migge on 06/10/23.
//

import SwiftUI

struct Hero {
    let name: String = ""
    let stats: [Stats] = []
}

struct Stats {
    var name: String
    var level: Float
}

struct StatsView: View {
    @Binding var stats: Stats
    
    public var body: some View {
        VStack {
            Text("Stats View")
            
            Text(stats.name)
            
            Text("Level \(stats.level)")
            
            Slider(value: $stats.level) {
                Text("Level")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("1")
            }
            
        }
        
    }
}

struct Teste: View {
    
    @State var statsList: [Stats] = [
        Stats(name: "Magic", level: 0.5),
        Stats(name: "Stamina", level: 0.5)
    ]
    
    var body: some View {
        ForEach(statsList.indices, id: \.self) { index in
            VStack {
                Text("Stats View")
                
                Text(statsList[index].name)
                
                Text("Level \(statsList[index].level)")
                    .padding(.bottom, 50)
                
                StatsView(stats: $statsList[index])
            }
        }
        
        
        
        
    }
}

#Preview {
    Teste()
}
