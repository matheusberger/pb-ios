//
//  NavigationModel.swift
//  PedalBoard
//
//  Created by Matheus Berger on 10/06/24.
//

import SwiftUI

@MainActor
final class NavigationModel: ObservableObject {
    @Published var navigationPath: NavigationPath
    
    init(navigationPath: NavigationPath = .init()) {
        self.navigationPath = navigationPath
    }
    
    func push(_ view: AppView) {
        navigationPath.append(view)
    }
    
    func pop(_ count: Int = 1) {
        guard count < navigationPath.count else {
            return toRoot()
        }
    }
    
    func toRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    enum AppView: Hashable, Sendable {
        case songList
        case songEdit
        case songDetail
        case pedalList
        case pedalEdit
    }
}
