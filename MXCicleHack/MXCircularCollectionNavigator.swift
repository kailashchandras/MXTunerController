//
//  MXCircularCollectionNavigator.swift
//  MXCicleHack
//
//  Created by Kailashchandra on 05/02/19.
//  Copyright © 2019 Kailashchandra. All rights reserved.
//

import UIKit



class MXCircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 200)
    var index = 0;
    var angle: CGFloat = 0 {
        
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: MXCircularCollectionViewLayoutAttributes =
            super.copy(with: zone) as! MXCircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
    
}

class MXCircularCollectionNavigator: UICollectionViewLayout {

    var attributesList = [MXCircularCollectionViewLayoutAttributes]()
    
    let itemSize = CGSize(width: 75, height: 75)
    
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0)-1)*anglePerItem : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme*collectionView!.contentOffset.y/(collectionViewContentSize.height - collectionView!.bounds.height)
    }
    
    var radius: CGFloat = 150 {
        didSet {
            invalidateLayout()
        }
    }
    var anglePerItem: CGFloat {
        return atan((itemSize.height) / (radius+50))
    }
    
    
    override var collectionViewContentSize: CGSize {

        return CGSize(width: CGFloat(collectionView!.bounds.width) ,
                        height: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width);
        
    }
    
    override class var layoutAttributesClass: AnyClass {
        return MXCircularCollectionViewLayoutAttributes.self
    }
    
    
    override func prepare() {
        
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width/2.0)
        
        
        let anchorPointY = ((itemSize.width/2.0)+(radius))/itemSize.width
        let theta = atan2(collectionView!.bounds.height/2.0, radius + (itemSize.width/2.0) - (collectionView!.bounds.width/2.0))
        
        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
        
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle)/anglePerItem))
        }
        
        endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))
        
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        attributesList = (startIndex...endIndex).map { (i) -> MXCircularCollectionViewLayoutAttributes in
            let attributes = MXCircularCollectionViewLayoutAttributes(forCellWith: IndexPath(row: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: 0, y: self.collectionView!.bounds.midY)
            attributes.angle = self.angle + (self.anglePerItem*CGFloat(i))
            attributes.anchorPoint = CGPoint(x: -anchorPointY, y: 0.5)
            attributes.index = i;
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    
//     override func layoutAttributesForItem(indexPath: IndexPath)
//        -> UICollectionViewLayoutAttributes! {
//            return attributesList[indexPath.row]
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    

}
