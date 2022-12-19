//
//  File.swift
//  
//
//  Created by Данила on 07.12.2022.
//

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
    func resize(_ maxSize: CGFloat) -> UIImage {
        let maxSizePixels = maxSize / UIScreen.main.scale
        let aspectRatio = size.width/size.height
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        if aspectRatio > 1 {
            width = maxSizePixels
            height = maxSizePixels / aspectRatio
        } else {
            height = maxSizePixels
            width = maxSizePixels * aspectRatio
        }
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: UIGraphicsImageRendererFormat.default())
        
        newImage = renderer.image { context in
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
