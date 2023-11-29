//
//  SongDetailViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 28/11/23.
//

import XCTest
@testable import PedalCore

final class SongDetailViewModelTests: XCTestCase {
    
    var viewModel: SongDetailViewModel!
    var delegate: AddsongDelegateMock!
    
    override func setUpWithError() throws {
        
        let song: Song = Song(name: "Example", artist: "Example", pedals: [Pedal(name: "pedal1", brand: "brand1", knobs: [Knob(name: "Leve")])])
        
        delegate = AddsongDelegateMock()
        viewModel = SongDetailViewModel(song: song, delegate: delegate)
        
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
    
    func testViewModelStateShouldNotChangeWhenEditingKnobsPressedOnEditingMusicPressed() {
        
        viewModel.state = .editingSong
        
        viewModel.editKnobsPressed()
        
        XCTAssertTrue(viewModel.state == .editingKnobs)

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
    
    func testSaveButtonsShouldPresentAlertWhenSongHasNoName() {
        viewModel.alertMessage = ""
        viewModel.isPresentingAlert = false
        viewModel.song = Song(name: "", artist: "Brand1", pedals: [])
        
        viewModel.saveButtonPressed()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        
    }
    
    func testSaveButtonsShouldPresentAlertWhenSongHasNoArtist() {
        viewModel.alertMessage = ""
        viewModel.isPresentingAlert = false
        viewModel.song = Song(name: "Song1", artist: "", pedals: [])
        
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
        let pedals: [Pedal] = [
            Pedal(name: "Pedal1", brand: "Brand1", knobs: []),
            Pedal(name: "Pedal2", brand: "Brand2", knobs: [])
        ]
        
        viewModel.userDidSelectNewPedals(pedals: pedals)
    
        XCTAssertFalse(viewModel.song.pedals.isEmpty)
        XCTAssertTrue(viewModel.song.pedals.contains(pedals[0]))
        XCTAssertTrue(viewModel.song.pedals.contains(pedals[1]))
        
    }
    
    
}
