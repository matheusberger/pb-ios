//
//  PedalCreationViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import XCTest
@testable import PedalBoard

final class PedalEditViewModelTests: XCTestCase {
    
    private var viewModel: Pedal.EditViewModel!
    
    override func setUpWithError() throws {
        viewModel = Pedal.EditViewModel() { _ in }
        continueAfterFailure = false
    }
    
    func testPedalInfosStartsEmpty() {
        XCTAssertTrue(viewModel.pedalName.isEmpty)
        XCTAssertTrue(viewModel.brandName.isEmpty)
        XCTAssertTrue(viewModel.knobs.isEmpty)
    }
    
    func testWhenEditingPedalViewModelHasRelatedStyle() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.EditViewModel(pedal) { _ in }
        
        XCTAssertTrue(viewModel.style == .editPedal)
        
    }
    
    func testWhenEditingPedalFieldsHasContent() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.EditViewModel(pedal) { _ in }
        
        
        XCTAssertFalse(viewModel.pedalName.isEmpty)
        XCTAssertFalse(viewModel.brandName.isEmpty)
        XCTAssertFalse(viewModel.knobs.isEmpty)
    }
    
    
    func testAddKnobPressedAppendstoKnobNamesArray() {
        viewModel.knobs = []
        viewModel.addKnobPressed()
        XCTAssertFalse(viewModel.knobs.isEmpty)
    }
    

    @MainActor
    func testRemoveKnobRemovesElementFromArray() {
        let knobs: [Pedal.Knob] = [
            Pedal.Knob(name: "Drive"),
            Pedal.Knob(name: "Tone"),
            Pedal.Knob(name: "Level")]
        viewModel.knobs = knobs
        
        viewModel.removeKnob(at: IndexSet(integer: 0))
        
        XCTAssertTrue(viewModel.knobs.count == 2)
        XCTAssertFalse(viewModel.knobs.contains(where: {$0.name == knobs.first!.name}))
    }
    
    func testOnSaveIsCalledWithNewPedal() async {
        var onSaveCalledExpectation = XCTestExpectation(description: "onSave callback was called")
        
        viewModel = Pedal.EditViewModel() { _ in
            onSaveCalledExpectation.fulfill()
        }
        viewModel.pedalName = "test"
        viewModel.brandName = "test"
        viewModel.knobs.append(.init(name: "test"))
        viewModel.doneButtonPressed()
        
        await fulfillment(of: [onSaveCalledExpectation], timeout: 10)
    }
    
    func testOnSaveIsCalledWithUpdatedPedal() async {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        let onSaveCalledExpectation = XCTestExpectation(description: "onSave callback was called")
        
        viewModel = Pedal.EditViewModel(pedal) { _ in
            onSaveCalledExpectation.fulfill()
        }
        
        viewModel.doneButtonPressed()
        
        await fulfillment(of: [onSaveCalledExpectation], timeout: 10)
    }
    
    func testPresentsAlertWhenErrorOccurs() {
        viewModel.isPresentingAlert = false
        let pedal = Pedal(name: "test", brand: "", knobs: [Pedal.Knob(name: "test")])
        
        viewModel = Pedal.EditViewModel(pedal) { _ in }
        viewModel.addNewPedal()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
    }
}
