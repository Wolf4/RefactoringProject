//
//  VideoGridItemTitleConverter.swift
//  CodingSession
//
//  Created by Ihar Rubanau on 25/11/24.
//

import Foundation

struct VideoGridItemTitleConverter {
    private let dateFormatter: DateComponentsFormatter
    
    init() {
        dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.zeroFormattingBehavior = [.pad]
        dateFormatter.unitsStyle = .positional
    }
    
    func title(from timeInterval: TimeInterval) -> String? {
        return dateFormatter.string(from: timeInterval)
    }
}
