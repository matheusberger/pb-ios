//
//  HomeViewModelsTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import XCTest
@testable import PedalCore

final class HomeViewModelsTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        
    }
    
    func testRemovePedalDeletsItFromPedalArray() {
        
        // given
        let pedal1 = Pedal(name: "name1", brand: "brand1", knobs: [])
        let pedal2 = Pedal(name: "name2", brand: "brand2", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        // when
        viewModel.removePedal(pedal1)
        
        // then
        XCTAssertFalse(viewModel.allPedals.contains(where: {$0 == pedal1}))
        XCTAssertTrue(viewModel.allPedals.contains(where: {$0 == pedal2}))
    }
    
}
