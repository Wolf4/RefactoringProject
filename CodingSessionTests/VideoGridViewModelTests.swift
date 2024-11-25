//
//  CodingSessionTests.swift
//  CodingSessionTests
//
//  Created by Ihar Rubanau on 25/11/24.
//

@testable import CodingSession
import XCTest
import RxBlocking

final class VideoGridViewModelTests: XCTestCase {

    var mockedVideosProvider = MockedVideoAssetsProvider()
    var mockedPreviewsProvider = MockedImagePreviewProvider()
    var sut: VideosGridViewModel!
    
    override func setUpWithError() throws {
        sut = VideosGridViewModel(videosProvider: mockedVideosProvider,
                                  imagePreviewsProvider:  mockedPreviewsProvider)
    }

    override func tearDownWithError() throws {
        mockedVideosProvider.mockedPhAssets = []
    }

    func testAuthorizationFailed() throws {
        mockedVideosProvider.mockedPhAssets = [
            MockedPHAsset(duration: 30),
            MockedPHAsset(duration: 40)
        ]
        mockedVideosProvider.mockedAuthorizationValue = false
        
        let result = try sut
            .loadItems()
            .toBlocking()
            .single()
        XCTAssertTrue(result.isEmpty)
    }

    func testAuthorizationSuccess() throws {
        mockedVideosProvider.mockedPhAssets = [
            MockedPHAsset(duration: 30),
            MockedPHAsset(duration: 40)
        ]
        mockedVideosProvider.mockedAuthorizationValue = true
        
        let result = try sut
            .loadItems()
            .toBlocking()
            .single()
        XCTAssertTrue(result.count == 2)
    }
    
    func testModelsCreation() throws {
        mockedVideosProvider.mockedPhAssets = [
            MockedPHAsset(duration: 7199),
            MockedPHAsset(duration: 30),
            MockedPHAsset(duration: 120),
            MockedPHAsset(duration: 9000),
            MockedPHAsset(duration: 86401),
        ]
        
        mockedVideosProvider.mockedAuthorizationValue = true
        
        let results = try sut
            .loadItems()
            .toBlocking()
            .single()
        
        let expectedTitles = [
            "01:59:59",
            "00:00:30",
            "00:02:00",
            "02:30:00",
            "24:00:01"
        ]
        
        XCTAssertEqual(results.count, expectedTitles.count)
        try results.enumerated().forEach { index, actualResult in
            let expectedResult = expectedTitles[index]
            XCTAssertEqual(expectedResult, actualResult.title)
            let resultImage = try actualResult.imageDriver.toBlocking().single()
            XCTAssertNotNil(resultImage)
            XCTAssertEqual(resultImage, mockedPreviewsProvider.mockedUIImage)
        }
    }
}
