//
//  VideosGridViewModel.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import RxSwift
import RxRelay
import RxCocoa

final class VideosGridViewModel {
    private let videosProvider: VideoAssetsProviding
    private let imagePreviewsProvider: ImagePreviewProviding
    private let titleConverter = VideoGridItemTitleConverter()
    private let disposeBag = DisposeBag()
    
    init(
        videosProvider: VideoAssetsProviding,
        imagePreviewsProvider: ImagePreviewProviding
    ) {
        self.videosProvider = videosProvider
        self.imagePreviewsProvider = imagePreviewsProvider
    }
    
    func loadItems() -> Driver<[VideoGridItemModel]> {
        return videosProvider.requestAuthorization()
            .filter { $0 }
            .flatMap { [unowned self] _ in videosProvider.fetchAssets() }
            .map { [unowned self] phasset in
                let title = titleConverter.title(from: phasset.duration)
                let imageDriver = imagePreviewsProvider
                    .requestImage(for: phasset)
                    .asDriver(onErrorJustReturn: nil)
                let itemModel = VideoGridItemModel(title: title,
                                                   imageDriver: imageDriver)
                return itemModel
            }
            .toArray()
            .asDriver(onErrorJustReturn: [])
    }
}

