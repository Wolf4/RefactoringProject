//
//  VideosGridAssembler.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import UIKit

struct VideosGridAssembler {
    func assembly(
    videosProvider: VideoAssetsProviding = VideoAssetsProvider(),
    imagePreviewsProvider: ImagePreviewProviding = ImagePreviewProvider()
    ) -> VideosGridViewController {
        let viewModel = VideosGridViewModel(videosProvider: videosProvider, imagePreviewsProvider: imagePreviewsProvider)
        let viewController = VideosGridViewController(viewModel: viewModel)
        return viewController
    }
}
