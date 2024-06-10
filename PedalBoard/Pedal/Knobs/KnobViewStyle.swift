//
//  KnobViewStyle.swift
//  PedalCore
//
//  Created by Lucas Migge on 27/11/23.
//

import Foundation

extension Pedal {
    enum KnobViewStyle {
        case reference, editing
        
        var strokeWidth: Double {
            switch self {
            case .reference:
                return 5
            case .editing:
                return 10
            }
        }
        
        var frameSize: Double {
            switch self {
            case .reference:
                return 40
            case .editing:
                return 80
            }
        }
        
        var circleSize: Double {
            switch self {
            case .reference:
                return 4
            case .editing:
                return 8
            }
        }
        
        var labelOffSet: Double {
            switch self {
            case .reference:
                return 30
            case .editing:
                return 40
            }
        }
        
        var stackSpacing: Double {
            switch self {
            case .reference:
                return 10
            case .editing:
                return 15
            }
        }
        
    }
}
