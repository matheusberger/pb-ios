//
//  CreateSongViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import XCTest
@testable import PedalCore

final class CreateSongViewModelTests: XCTestCase {
    
    var viewModel: CreateSongViewModel!
    var delegate: AddsongDelegateMock!
    
    override func setUpWithError() throws {
        delegate = AddsongDelegateMock()
        viewModel = CreateSongViewModel(delegate: delegate)
        
    }
    
    func testViewModelStartsWithEmptyFields() {
        
        XCTAssertTrue(viewModel.songName.isEmpty)
        XCTAssertTrue(viewModel.bandName.isEmpty)
        XCTAssertTrue(viewModel.pedalList.isEmpty)
        
        XCTAssertFalse(viewModel.isPresentingAlert)
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testUpdateSelectedPedalsUpdatedPedalList() {
        let pedal1 = Pedal.Model(name: "test1", brand: "test1", knobs: [])
        let pedal2 = Pedal.Model(name: "test2", brand: "test2", knobs: [])
        let pedal3 = Pedal.Model(name: "test3", brand: "test3", knobs: [])
        let selectedPedal = [pedal2, pedal3]
        viewModel.pedalList = [pedal1]

        viewModel.updateSelectedPedals(selectedPedal)
                
        XCTAssertFalse(viewModel.pedalList.contains(pedal1))
        XCTAssertTrue(viewModel.pedalList.contains(pedal2))
        XCTAssertTrue(viewModel.pedalList.contains(pedal3))
        
    }

    func testUpdateRemovePedalRemovesItFromPedalList() {
        let pedal1 = Pedal.Model(name: "test1", brand: "test1", knobs: [])
        let pedal2 = Pedal.Model(name: "test2", brand: "test2", knobs: [])
        let pedal3 = Pedal.Model(name: "test3", brand: "test3", knobs: [])
        let pedals = [pedal1, pedal2, pedal3]
        viewModel.pedalList = pedals

        viewModel.removePedal(pedal1)
        
        XCTAssertFalse(viewModel.pedalList.contains(pedal1))
        XCTAssertTrue(viewModel.pedalList.contains(pedal2))
        XCTAssertTrue(viewModel.pedalList.contains(pedal3))
        
    }
    
    func testAddSongPressedCallDelegate() {
        delegate.didCallAddSong = false
        
        viewModel.addSongPressed()
        
        XCTAssertTrue(delegate.didCallAddSong)
    }
    
    func testWhenDelegateTrowsErrorAlertIsPresented() {
        
        delegate.shouldThrowAddSongError = .missingArtist
        
        viewModel.addSongPressed()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
        XCTAssertEqual(viewModel.alertMessage, AddSongError.missingArtist.alertDescription)
    }
    
    func testAttachPedalPresentsPedalSheet() {
        viewModel.isPresentingSheet = false
        
        viewModel.attachPedalPressed()
        
        XCTAssertTrue(viewModel.isPresentingSheet)
    }
    
    func testUpdatePedalListFromSheetSelectedPedals() {
        viewModel.pedalList = []
        let pedal1 = Pedal.Model(name: "test1", brand: "test1", knobs: [])
        let pedal2 = Pedal.Model(name: "test2", brand: "test2", knobs: [])
        let pedal3 = Pedal.Model(name: "test3", brand: "test3", knobs: [])
        let selectedPedals = [pedal1, pedal2, pedal3]

        viewModel.updateSelectedPedals(selectedPedals)
        
        XCTAssertTrue(viewModel.pedalList.contains(where: {selectedPedals.contains($0)}))
    }

}
