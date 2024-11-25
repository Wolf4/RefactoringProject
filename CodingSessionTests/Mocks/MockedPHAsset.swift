//
//  MockedPHAsset.swift
//  CodingSessionTests
//
//  Created by Ihar Rubanau on 25/11/24.
//

import Photos

class MockedPHAsset: PHAsset, @unchecked Sendable {
    private let mockedDuration: TimeInterval
    
    override var duration: TimeInterval {
        return mockedDuration
    }
    
    init(duration: TimeInterval) {
        self.mockedDuration = duration
    }
}
