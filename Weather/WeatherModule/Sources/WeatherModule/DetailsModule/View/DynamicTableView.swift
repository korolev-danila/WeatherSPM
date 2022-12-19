//
//  File.swift
//  
//
//  Created by Данила on 13.12.2022.
//

import UIKit

final class DynamicTableView: UITableView {
    var dynamicRowHeight: CGFloat = UITableView.automaticDimension {
        didSet {
            rowHeight = UITableView.automaticDimension
            estimatedRowHeight = dynamicRowHeight
        }
    }

    override var intrinsicContentSize: CGSize { contentSize }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
}
