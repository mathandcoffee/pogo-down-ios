//
//  String+Dystoria.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        if count == 0 { return 0 }
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        return ceil(boundingBox.width)
    }
    
    func formattedDateString() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        guard let date = isoDateFormatter.date(from: self) else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)

        return "\(month) \(year)"
    }
    
    func date() -> Date? {
        return ISO8601DateFormatter().date(from: self)
    }
}
