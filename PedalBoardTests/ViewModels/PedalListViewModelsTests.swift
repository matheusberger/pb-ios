//
//  PedalListViewModelsTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import XCTest
import PedalCore
@testable import PedalBoard

final class PedalListViewModelsTests: XCTestCase {
    
    private var viewModel: Pedal.ListViewModel!
    
    @MainActor override func setUpWithError() throws {
        let persistance = JsonDataService<Pedal>(fileName: "TestingFile")
        let provider = LocalDataProvider<Pedal>(persistence: persistance)
        viewModel = Pedal.ListViewModel(provider: provider)
        
        continueAfterFailure = false
    }
    
    @MainActor func testRemovePedalDeletsItFromPedalArray() {
        // given
        let pedal1 = Pedal(name: "name1", brand: "brand1", knobs: [])
        let pedal2 = Pedal(name: "name2", brand: "brand2", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        // when
        viewModel.removePedalPressed(pedal1)
        
        // then
        XCTAssertFalse(viewModel.allPedals.contains(where: {$0 == pedal1}))
        XCTAssertTrue(viewModel.allPedals.contains(where: {$0 == pedal2}))
    }
    
    @MainActor func testSearchWithValidInfoFiltersShowPedals() {
        let pedal1 = Pedal(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        viewModel.searchText = "space"
        
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal1}))
        XCTAssertFalse(viewModel.filteredPedals.contains(where: {$0 == pedal2}))
    }
    
    @MainActor func testSearchWithBrandNameFiltersPedals() {
        let pedal1 = Pedal(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal(name: "Overdrive 3", brand: "Boss", knobs: [])
        let pedal3 = Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2, pedal3]
        
        viewModel.searchText = "boss"
        
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal1}))
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal2}))
        XCTAssertFalse(viewModel.filteredPedals.contains(where: {$0 == pedal3}))
    }
    
    @MainActor func testSeachWithWrongInfoFiltersEveryPedals() {
        let pedal1 = Pedal(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        viewModel.searchText = "spaceeeeeeeeeeeeee"
        
        XCTAssertTrue(viewModel.filteredPedals.isEmpty)
    }
    
    
    @MainActor func testAddPedalWithValidInfoAppendsToPedalArray() {
        let name = "pedalName"
        let brand = "brand"
        let knobs = [Pedal.Knob(name: "Knob1"), Pedal.Knob(name: "Knob2")]
        let newPedal = Pedal(name: name, brand: brand, knobs: knobs)
        
        viewModel.allPedals.append(newPedal)
        
        XCTAssertTrue(viewModel.allPedals.contains(where: {$0 == newPedal}))
    }
}
