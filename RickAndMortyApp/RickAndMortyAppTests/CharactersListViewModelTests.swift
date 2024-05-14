//
//  CharactersListViewModelTests.swift
//  RickAndMortyAppTests
//
//  Created by Ton Silva on 14/5/24.
//

import XCTest
@testable import RickAndMortyApp

@MainActor
final class CharactersListViewModelTests: XCTestCase {
    var viewModel: CharactersListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = CharactersListViewModel()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
        
    }
    
    func testLoadCharactersListSuccess() {
        // Given
        let mockCharacters = [RMCharacterModel.mock(), RMCharacterModel.mock()]
        let mockDataManager = MockCharacterDataManager(characters: mockCharacters)
        viewModel.dataManager = mockDataManager
        
        let expectation = expectation(description: "Characters loaded successfully")
        
        // When
        viewModel.loadCharactersList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            // Then
            XCTAssertEqual(self.viewModel.charactersList, mockCharacters)
            XCTAssertFalse(self.viewModel.isLoadingList)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLoadCharactersListFailure() {
        // Given
        let mockError = NSError(domain: "MockError", code: 0, userInfo: nil)
        let mockDataManager = MockCharacterDataManager(error: mockError)
        viewModel.dataManager = mockDataManager
        
        // When
        viewModel.loadCharactersList()
        
        // Then
        let expectation = expectation(description: "Error occurred while loading characters")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            XCTAssertTrue(self.viewModel.errorOnLoadingListString.contains("MockError"))
            XCTAssertFalse(self.viewModel.isLoadingList)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testCancelTasks() {
        // Given
        let mockTask = Task { }
        viewModel.tasks = [mockTask]
        
        // When
        viewModel.cancelTasks()
        
        // Then
        XCTAssertTrue(viewModel.tasks.isEmpty)
    }
    
    func testDetermineGenderPronoun() {
        // Given
        let maleCharacter = RMCharacterModel.mockTestsMaleGender()
        
        let femaleCharacter = RMCharacterModel.mockTestsFemaleGender()
        
        // When
        let malePronoun = viewModel.determineGenderPronoun(character: maleCharacter)
        let femalePronoun = viewModel.determineGenderPronoun(character: femaleCharacter)
        
        // Then
        XCTAssertEqual(malePronoun, "he")
        XCTAssertEqual(femalePronoun, "she")
    }
    
    func testFormatPlanetDescription() {
        // Given
        let knownOriginCharacter = RMCharacterModel.mock()
        let unknownOriginCharacter = RMCharacterModel.mockTestsUnkownCharacter()
        
        // When
        let knownOriginDescription = viewModel.formatPlanetDescription(character: knownOriginCharacter)
        let unknownOriginDescription = viewModel.formatPlanetDescription(character: unknownOriginCharacter)
        
        // Then
        XCTAssertEqual(knownOriginDescription, "is from the planet called Earth")
        XCTAssertEqual(unknownOriginDescription, "has your origin still unknown")
    }
    
    func testFormatEpisodeDescription() {
        // Given
        let characterWithOneEpisode = RMCharacterModel.mock()
        let characterWithMultipleEpisodes = RMCharacterModel.mockTestsMultipleEpisodes()
        
        // When
        let oneEpisodeDescription = viewModel.formatEpisodeDescription(character: characterWithOneEpisode)
        let multipleEpisodesDescription = viewModel.formatEpisodeDescription(character: characterWithMultipleEpisodes)
        
        // Then
        XCTAssertEqual(oneEpisodeDescription, "1 episode")
        XCTAssertEqual(multipleEpisodesDescription, "2 episodes")
    }
}
