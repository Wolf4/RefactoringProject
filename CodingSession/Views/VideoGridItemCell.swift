//
//  VideoGridItemCell.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import UIKit
import RxCocoa
import RxSwift

final class VideoGridItemCell: UICollectionViewCell {
    
    static let contentSize = CGSize(width: UIScreen.main.bounds.width / 3,
                                    height: UIScreen.main.bounds.width / 3)
    
    private let thumbImageView = UIImageView()
    private let durationLabel = UILabel()
    
    private var disposeBag = DisposeBag()
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        print("reuse \(disposeBag)")
    }
    
    private func setupUI() {
        contentView.addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        
        contentView.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
    
    func configure(with model: VideoGridItemModel) {
        durationLabel.text = model.title
        model.imageDriver
            .drive(thumbImageView.rx.image)
            .disposed(by: disposeBag)
        
        model.imageDriver.drive { image in
            print("image drives \(model.title ?? "nil")")
        }
    }
}
