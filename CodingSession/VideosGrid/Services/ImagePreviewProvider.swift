//
//  ImagePreviewProvider.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import RxSwift
import Photos
import UIKit

protocol ImagePreviewProviding {
    func requestImage(for asset: PHAsset) -> Observable<UIImage?>
}

final class ImagePreviewProvider: ImagePreviewProviding {
    
    private let phImageManager = PHImageManager.default()
    
    func requestImage(for asset: PHAsset) -> Observable<UIImage?> {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        return requestImage(for: asset,
                            targetSize: VideoGridItemCell.contentSize,
                            contentMode: .aspectFill,
                            options: requestOptions)
    }
    
    private func requestImage(
        for asset: PHAsset,
        targetSize: CGSize,
        contentMode: PHImageContentMode,
        options: PHImageRequestOptions?
    ) -> Observable<UIImage?> {

        return Observable.create({ [weak manager = self.phImageManager] (observer) -> Disposable in
            guard let manager = manager else {
                observer.onCompleted()
                return Disposables.create()
            }

            let requestID = manager
                .requestImage(for: asset,
                              targetSize: targetSize,
                              contentMode: contentMode,
                              options: options,
                              resultHandler: { (image, _) in
                    observer.onNext(image)
                    observer.onCompleted()
                })

            return Disposables.create {
                manager.cancelImageRequest(requestID)
            }
        })
    }
}
