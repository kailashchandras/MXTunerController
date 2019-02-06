//
//  CellItem.swift
//  MXCicleHack
//
//  Created by Kailashchandra on 05/02/19.
//  Copyright © 2019 Kailashchandra. All rights reserved.
//

import UIKit

class CellItem: UICollectionViewCell {
    
    var imageName = "" {
        didSet {
            imageView!.image = UIImage(named: imageName)
        }
    }

    
   
    
    @IBOutlet weak var imageView: UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        contentView.layer.borderWidth = 2
        contentView.layer.masksToBounds = false
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = contentView.frame.height/2
        contentView.clipsToBounds = true
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView!.contentMode = .scaleAspectFill
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes!) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! MXCircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5)*(self.bounds.height)
        self.center.x = 0;
        
        
        imageView?.alpha = CGFloat(0.9 - (abs(circularlayoutAttributes.angle)))
        print(circularlayoutAttributes.center.y );
    }
    
}

