//
//  CreatePedalViewModelTestes.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import XCTest
@testable import PedalCore

final class CreatePedalViewModelTests: XCTestCase {
    
    private var viewModel: CreatePedalViewModel!
    private var delegate: CreatePedalDelegateMock!
    
    override func setUpWithError() throws {
        delegate = CreatePedalDelegateMock()
        viewModel = CreatePedalViewModel(delegate: self.delegate)
        
        continueAfterFailure = false
        
    }
    
    func testPedalInfosStartsEmpty() {
        XCTAssertTrue(viewModel.pedalName.isEmpty)
        XCTAssertTrue(viewModel.brandName.isEmpty)
        XCTAssertTrue(viewModel.knobNames.isEmpty)
    }
    
    func testWhenEditingPedalViewModelHasRelatedStyle() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Knob(name: "test")])
        viewModel = CreatePedalViewModel(editPedal: pedal)
        
        XCTAssertTrue(viewModel.style == .editPedal)
        
    }
    
    func testWhenEditingPedalFieldsHasContent() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Knob(name: "test")])
        viewModel = CreatePedalViewModel(editPedal: pedal)
        
        
        XCTAssertFalse(viewModel.pedalName.isEmpty)
        XCTAssertFalse(viewModel.brandName.isEmpty)
        XCTAssertFalse(viewModel.knobNames.isEmpty)
    }
    
    
    func testAddKnobPressedAppendstoKnobNamesArray() {
        viewModel.knobNames = []
        
        viewModel.addKnobPressed()
        
        XCTAssertFalse(viewModel.knobNames.isEmpty)
        
    }
    
    func testRemoveKnobRemovesElementFromArray() {
        viewModel.knobNames = ["Drive", "Tone", "Level"]
        
        viewModel.removeKnob(at: IndexSet(integer: 0))
        
        XCTAssertTrue(viewModel.knobNames.count == 2)
        XCTAssertFalse(viewModel.knobNames.contains(where: {$0 == "Drive"}))
        
    }
    
    
    func testWhenOnCreatePedalStyleDoneButtonCallsAddNewPedal() {
        
        viewModel.doneButtonPressed()
        
        XCTAssertTrue(delegate.didCallAddNewPedal)
    }
    
    
    func testWhenOnEditPedalStyleDoneButtonCallsEdidPedalDone() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Knob(name: "test")])
        viewModel = CreatePedalViewModel(delegate: self.delegate, editPedal: pedal)
        
        viewModel.doneButtonPressed()
        
        XCTAssertTrue(delegate.didCallFinishedEditingPedal)
    }

    func testAddNewPedalPresentsAlertWhenErrorOccurs() {
        viewModel.isPresentingAlert = false
        delegate.addNewPedalShouldThrowError = .missingBrand
        
        viewModel.addNewPedal()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
    }
    
    func testEditPedalPresentsAlertWhenErrorOccurs() {
        let pedal = Pedal(name: "test", brand: "test", knobs: [Knob(name: "test")])
        viewModel = CreatePedalViewModel(delegate: self.delegate, editPedal: pedal)
        viewModel.isPresentingAlert = false
        delegate.finishedEditingPedalShouldThrowError = .missingBrand
        
        viewModel.editPedalDone()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
    }
   
}
