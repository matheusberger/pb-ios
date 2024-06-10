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
    
    override func setUpWithError() throws {
        let persistance = JsonDataService<Pedal.Model>(fileName: "TestingFile")
        let provider = LocalDataProvider<Pedal.Model>(persistence: persistance)
        viewModel = Pedal.ListViewModel(provider: provider)
        
        continueAfterFailure = false
    }
    
    func testRemovePedalDeletsItFromPedalArray() {

        // given
        let pedal1 = Pedal.Model(name: "name1", brand: "brand1", knobs: [])
        let pedal2 = Pedal.Model(name: "name2", brand: "brand2", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        // when
        viewModel.removePedalPressed(pedal1)
        
        // then
        XCTAssertFalse(viewModel.allPedals.contains(where: {$0 == pedal1}))
        XCTAssertTrue(viewModel.allPedals.contains(where: {$0 == pedal2}))
    }
    
    func testSearchWithValidInfoFiltersShowPedals() {
        
        let pedal1 = Pedal.Model(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal.Model(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        viewModel.searchText = "space"
        
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal1}))
        XCTAssertFalse(viewModel.filteredPedals.contains(where: {$0 == pedal2}))
    }
    
    func testSearchWithBrandNameFiltersPedals() {
        
        let pedal1 = Pedal.Model(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal.Model(name: "Overdrive 3", brand: "Boss", knobs: [])
        let pedal3 = Pedal.Model(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2, pedal3]
        
        viewModel.searchText = "boss"
        
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal1}))
        XCTAssertTrue(viewModel.filteredPedals.contains(where: {$0 == pedal2}))
        XCTAssertFalse(viewModel.filteredPedals.contains(where: {$0 == pedal3}))
        
    }
    
    func testSeachWithWrongInfoFiltersEveryPedals() {
        
        let pedal1 = Pedal.Model(name: "Space Echo", brand: "Boss", knobs: [])
        let pedal2 = Pedal.Model(name: "Tube Screamer", brand: "Ibanez", knobs: [])
        viewModel.allPedals = [pedal1, pedal2]
        
        viewModel.searchText = "spaceeeeeeeeeeeeee"
        
        XCTAssertTrue(viewModel.filteredPedals.isEmpty)
    }
    
    
    func testAddPedalWithValidInfoAppendsToPedalArray() {
        
        let name = "pedalName"
        let brand = "brand"
        let knobs = [Pedal.Knob(name: "Knob1"), Pedal.Knob(name: "Knob2")]
        let newPedal = Pedal.Model(name: name, brand: brand, knobs: knobs)
        
        try? viewModel.addNewPedal(newPedal)
        
        XCTAssertTrue(viewModel.allPedals.contains(where: {$0 == newPedal}))
    }
    
    func testAddPedalWithInvalidInfoThrowsError() {
        
        let name = ""
        let brand = ""
        let knobs: [Pedal.Knob] = []
        let newPedal = Pedal.Model(name: name, brand: brand, knobs: knobs)
        
        XCTAssertThrowsError(try viewModel.addNewPedal(newPedal))
    }
    
    func testEditPedalPressedPutsPedalToEditPedalReference() {
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        
        viewModel.editPedalPressed(pedal)
        
        XCTAssertEqual(pedal, viewModel.editPedal)
    }
    
    func testDismissingSheetTurnsEditPedalToNil() {
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel.editPedal = pedal
        
        viewModel.sheetDidDismiss()
        
        XCTAssertNil(viewModel.editPedal)
    }
}
