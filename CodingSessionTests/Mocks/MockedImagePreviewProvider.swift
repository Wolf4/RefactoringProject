//
//  MockedImagePreviewProvider.swift
//  CodingSessionTests
//
//  Created by Ihar Rubanau on 25/11/24.
//

@testable import CodingSession
import RxSwift
import Photos
import UIKit

class MockedImagePreviewProvider: ImagePreviewProviding {
    
    var mockedUIImage: UIImage = UIImage()
    func requestImage(for asset: PHAsset) -> RxSwift.Observable<UIImage?> {
        return Observable.just(mockedUIImage)
    }
    
}
