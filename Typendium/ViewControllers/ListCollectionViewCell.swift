//
//  ListCollectionViewCell.swift
//  Typendium
//
//  Created by William Robinson on 10/08/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure() {
        titleLabel.text = "test"
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.lightGray
        contentView.layer.cornerRadius = 20
    }
}
