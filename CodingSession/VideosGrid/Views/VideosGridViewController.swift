//
//  VideosGridViewController.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class VideosGridViewController: UIViewController {
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    private let viewModel: VideosGridViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: VideosGridViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSubscriptions()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.register(VideoGridItemCell.self,
                                forCellWithReuseIdentifier: VideoGridItemCell.reuseIdentifier)
    }
    
    private func setupSubscriptions() {
        viewModel.loadItems()
            .drive(collectionView.rx.items(
                cellIdentifier: VideoGridItemCell.reuseIdentifier,
                cellType: VideoGridItemCell.self
            )) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
    }
}

extension VideosGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        VideoGridItemCell.contentSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
