//
//  MockedVideoAssetsProvider.swift
//  CodingSessionTests
//
//  Created by Ihar Rubanau on 25/11/24.
//

@testable import CodingSession
import RxSwift
import Photos

class MockedVideoAssetsProvider: VideoAssetsProviding {
    
    var mockedAuthorizationValue: Bool = true
    func requestAuthorization() -> RxSwift.Observable<Bool> {
        Observable.just(mockedAuthorizationValue)
    }
    
    var mockedPhAssets: [PHAsset] = []
    func fetchAssets() -> RxSwift.Observable<PHAsset> {
        return Observable.create { observer in
            self.mockedPhAssets.forEach { phAsset in
                observer.onNext(phAsset)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
