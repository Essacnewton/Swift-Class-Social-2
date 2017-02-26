//
//  CircleView.swift
//  Swift Class Social 2
//
//  Created by Isaac Prunty on 2/25/17.
//  Copyright © 2017 Isaac Prunty. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
