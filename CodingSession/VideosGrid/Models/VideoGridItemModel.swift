//
//  VideoGridItemModel.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import UIKit
import RxCocoa

struct VideoGridItemModel {
    let title: String?
    let imageDriver: Driver<UIImage?>
}

