//
//  VideoAssetsProvider.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import RxSwift
import Photos

protocol VideoAssetsProviding {
    func requestAuthorization() -> Observable<Bool>
    func fetchAssets() -> Observable<PHAsset>
}

final class VideoAssetsProvider: VideoAssetsProviding {
    private let imageManager = PHCachingImageManager()

    func fetchAssets() -> Observable<PHAsset> {
        Observable.create { observer in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)

            let fetchResult = PHAsset.fetchAssets(with: fetchOptions)

            fetchResult.enumerateObjects { asset, _, _ in
                observer.onNext(asset)
            }
            observer.onCompleted()

            return Disposables.create()
        }
    }

    func requestAuthorization() -> Observable<Bool> {
        Observable.create { observer in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                let granted = status == .authorized || status == .limited
                observer.onNext(granted)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
