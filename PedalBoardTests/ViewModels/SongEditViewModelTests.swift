//
//  SongCreationViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import XCTest
import PedalCore
@testable import PedalBoard

final class SongEditViewModelTests: XCTestCase {
    
    var viewModel: Song.EditViewModel!
    var availablePedals: [Pedal]!
    
    override func setUpWithError() throws {
        let pedal1 = Pedal(name: "test1", brand: "test1", knobs: [])
        let pedal2 = Pedal(name: "test2", brand: "test2", knobs: [])
        let pedal3 = Pedal(name: "test3", brand: "test3", knobs: [])
        
        availablePedals = [pedal1, pedal2, pedal3]
        viewModel = Song.EditViewModel(availablePedals: availablePedals) { song in }
    }
    
    func testViewModelStartsWithEmptyFields() {
        XCTAssertTrue(viewModel.songName.isEmpty)
        XCTAssertTrue(viewModel.bandName.isEmpty)
        XCTAssertTrue(viewModel.pedalList.isEmpty)
        
        XCTAssertFalse(viewModel.isPresentingAlert)
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testUpdateSelectedPedalsUpdatedPedalList() {
        let selectedPedal = [availablePedals[1], availablePedals[2]]
        viewModel.pedalList = [availablePedals[0]]

        viewModel.updateSelectedPedals(selectedPedal)
                
        XCTAssertFalse(viewModel.pedalList.contains(availablePedals[0]))
        XCTAssertTrue(viewModel.pedalList.contains(selectedPedal))
    }

    func testUpdateRemovePedalRemovesItFromPedalList() {
        viewModel.pedalList = availablePedals

        viewModel.removePedal(availablePedals[0])
        
        XCTAssertFalse(viewModel.pedalList.contains(availablePedals[0]))
        XCTAssertTrue(viewModel.pedalList.contains(availablePedals[1]))
        XCTAssertTrue(viewModel.pedalList.contains(availablePedals[2]))
        
    }
    
    func testOnSaveIsCalled() async {
        let onSaveCalledExpectation = XCTestExpectation(description: "completion handler was called")
        
        viewModel = Song.EditViewModel(availablePedals: availablePedals) { _ in
            onSaveCalledExpectation.fulfill()
        }
        await viewModel.addSongPressed()
        
        await fulfillment(of: [onSaveCalledExpectation])
    }
    
    func testPresentsAlertIfError() async {
        // do nothing since viewModel's song fields are all empty
        await viewModel.addSongPressed()
        
        XCTAssertTrue(viewModel.isPresentingAlert)
        XCTAssertEqual(viewModel.alertMessage, Song.EditError.missingArtist.alertDescription)
    }
    
    func testUpdatePedalListFromSheetSelectedPedals() {
        viewModel.pedalList = []
        viewModel.updateSelectedPedals(availablePedals)
        
        XCTAssertTrue(viewModel.pedalList.contains(where: {availablePedals.contains($0)}))
    }

}
