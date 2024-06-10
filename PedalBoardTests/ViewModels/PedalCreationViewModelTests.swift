//
//  PedalCreationViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import XCTest
@testable import PedalBoard

final class PedalCreationViewModelTests: XCTestCase {
    
    private var viewModel: Pedal.Creation.ViewModel!
    private var delegate: PedalCreationDelegateMock!
    
    override func setUpWithError() throws {
        delegate = PedalCreationDelegateMock()
        viewModel = Pedal.Creation.ViewModel(delegate: self.delegate)
        
        continueAfterFailure = false
        
    }
    
    func testPedalInfosStartsEmpty() {
        XCTAssertTrue(viewModel.pedalName.isEmpty)
        XCTAssertTrue(viewModel.brandName.isEmpty)
        XCTAssertTrue(viewModel.knobs.isEmpty)
    }
    
    func testWhenEditingPedalViewModelHasRelatedStyle() {
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.Creation.ViewModel(editPedal: pedal)
        
        XCTAssertTrue(viewModel.style == .editPedal)
        
    }
    
    func testWhenEditingPedalFieldsHasContent() {
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.Creation.ViewModel(editPedal: pedal)
        
        
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
    
    
    func testWhenOnCreatePedalStyleDoneButtonCallsAddNewPedal() {
        
        viewModel.doneButtonPressed()
        
        XCTAssertTrue(delegate.didCallAddNewPedal)
    }
    
    
    func testWhenOnEditPedalStyleDoneButtonCallsEdidPedalDone() {
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.Creation.ViewModel(delegate: self.delegate, editPedal: pedal)
        
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
        let pedal = Pedal.Model(name: "test", brand: "test", knobs: [Pedal.Knob(name: "test")])
        viewModel = Pedal.Creation.ViewModel(delegate: self.delegate, editPedal: pedal)
        viewModel.isPresentingAlert = false
        delegate.finishedEditingPedalShouldThrowError = .missingBrand
        
        viewModel.editPedalDone()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
    }
    
}
