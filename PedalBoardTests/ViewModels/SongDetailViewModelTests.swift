//
//  SongDetailViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 28/11/23.
//

import XCTest
@testable import PedalBoard

final class SongDetailViewModelTests: XCTestCase {
    
    var viewModel: Song.DetailViewModel!
    var delegate: MockSongEditDelegate!
    
    override func setUpWithError() throws {
        
        let song = Song.Model(name: "Example", artist: "Example", pedals: [Pedal.Model(name: "pedal1", brand: "brand1", knobs: [Pedal.Knob(name: "Leve")])])
        
        delegate = MockSongEditDelegate()
        viewModel = Song.DetailViewModel(song: song, delegate: delegate)
        
    }
    
    // MARK: - State tests
    
    func testViewModelStartsWithPresentationState() {
        
        XCTAssertTrue(viewModel.state == .presentation)
    }
    
    func testViewModelStartsWithSaveButtonHidden() {
        
        XCTAssertFalse(viewModel.hasChanges)
    }
    
    func testSaveButtonShouldApperWhenEditingEnable() {
        
        viewModel.hasChanges = false
        
        viewModel.editKnobsPressed()
        
        XCTAssertTrue(viewModel.hasChanges)
    }
    
    func testViewModelStateSetToEditingKnobsWhenEditingKnobsPressed() {
        
        viewModel.state = .presentation
        
        viewModel.editKnobsPressed()
        
        XCTAssertTrue(viewModel.state == .editingKnobs)

    }
    
    func testViewModelStateShouldNotChangeWhenEditingKnobsPressedOnEditingSongMode() {
        
        viewModel.state = .editingSong
        
        viewModel.editKnobsPressed()
        
        XCTAssertTrue(viewModel.state == .editingSong)

    }
    
    func testViewModelStateSetToEditSongWhenEditSongPressed() {
        
        viewModel.state = .presentation
        
        viewModel.editSongPressed()
        
        XCTAssertTrue(viewModel.state == .editingSong)
        
    }
    
    func testSaveButtonCallsDelegate() {
        delegate.didCallAddSong = false

        viewModel.saveButtonPressed()
        
        XCTAssertTrue(delegate.didCallAddSong)
        
    }
    
    func testSaveButtonsShouldPresentAlertWhenDelegateThrowAnError() {
        viewModel.isPresentingAlert = false
        viewModel.alertMessage = ""
        delegate.shouldThrowAddSongError = .missingName

        
        viewModel.saveButtonPressed()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        
    }
    
    func testChangePedalsButtonPressedPresentsSheet() {
        
        viewModel.isPresentingSheet = false
        
        viewModel.ChangePedalsButtonPressed()
        
        XCTAssertTrue(viewModel.isPresentingSheet)
        
    }
    
    func testUserDidSelectNewPedalsUpdatesViewModelPedals() {
        
        viewModel.song.pedals = []
        let pedals: [Pedal.Model] = [
            Pedal.Model(name: "Pedal1", brand: "Brand1", knobs: []),
            Pedal.Model(name: "Pedal2", brand: "Brand2", knobs: [])
        ]
        
        viewModel.userDidSelectNewPedals(pedals: pedals)
    
        XCTAssertFalse(viewModel.song.pedals.isEmpty)
        XCTAssertTrue(viewModel.song.pedals.contains(pedals[0]))
        XCTAssertTrue(viewModel.song.pedals.contains(pedals[1]))
        
    }
    
    func testViewModeReturnRelateStateMode() {
        
        viewModel.state = .editingKnobs
        
        XCTAssertTrue(viewModel.isInEditing)
        
        viewModel.state = .editingSong
        
        XCTAssertTrue(viewModel.isInEditing)
        
        viewModel.state = .presentation
        
        XCTAssertTrue(viewModel.isInPresentationMode)
    }
}
