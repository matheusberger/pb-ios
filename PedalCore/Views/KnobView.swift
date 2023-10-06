//
//  KnobView.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI


struct KnobView: View {
    
    @ObservedObject var viewModel: KnobViewModel
    
    

    private func maxTrin(for level: Float) -> CGFloat {
        return CGFloat(0.75 * level)
    }
    
    private var roundedLevel: Int {
        Int(round(viewModel.level * 100))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.parameter)
                .font(.subheadline)
            
            Text("\(roundedLevel) %")
                .font(.subheadline)
            
            ZStack {
                Circle()
                    .trim(from: 0.0, to: maxTrin(for: 1))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(135))
                    .frame(width: 100, height: 100)
                    .opacity(0.15)
                
                
                Circle()
                    .trim(from: 0.0, to: maxTrin(for: viewModel.level))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(135))
                    .frame(width: 100, height: 100)
                
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 10, height: 10)
            }
            
        }
        .gesture(DragGesture().onChanged { value in
            viewModel.dragAction(value: value.translation)
            
        }.onEnded { _ in
            viewModel.dragEnded()
        })
    }
}


struct KnobView_Previews: PreviewProvider {
    static var knob = Knob(parameter: "Drive", level: 0.5)
    static var previews: some View {
        KnobView(viewModel: KnobViewModel(knob: knob))
    }
}