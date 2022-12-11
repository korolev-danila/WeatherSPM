//
//  File.swift
//  
//
//  Created by Данила on 07.12.2022.
//

import Foundation
import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

extension UIImage {
    /// change the image size by pixels
    func resize(_ max_size: CGFloat) -> UIImage {
        let max_size_pixels = max_size / UIScreen.main.scale
        let aspectRatio =  size.width/size.height
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        if aspectRatio > 1 {
            width = max_size_pixels
            height = max_size_pixels / aspectRatio
        } else {
            height = max_size_pixels
            width = max_size_pixels * aspectRatio
        }
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: UIGraphicsImageRendererFormat.default())
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
}

extension UITableView {
    /// need for animation 
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    /// news.description need this
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
