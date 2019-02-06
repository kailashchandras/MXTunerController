//
//  MXOverlayMoodView.swift
//  MXCicleHack
//
//  Created by Kailashchandra on 06/02/19.
//  Copyright © 2019 Kailashchandra. All rights reserved.
//

import UIKit

struct Segment {
    
    // the color of a given segment
    var color: UIColor
    
    // the value of a given segment – will be used to automatically calculate a ratio
    var value: CGFloat
    
    var img: UIImage
}

class MXOverlayMoodView: UIView {

    
    var imageView: UIImageView?
    /// An array of structs representing the segments of the pie chart
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
    var cordinate = [CGPoint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.size.width, frame.size.height) * 0.5
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        // enumerate the total value of the segments by using reduce to sum them
        let valueCount = segments.reduce(0, {$0 + $1.value})
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
        cordinate.removeAll();
        
        for (index, segment) in segments.enumerated() { // loop through the values array
            
            ctx?.setLineWidth(0.4)
            // set fill color to the segment color
            ctx?.setStrokeColor(UIColor.lightGray.cgColor)
            
            // update the end angle of the segment
            let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)
            ctx?.move(to: viewCenter)
            ctx?.addEllipse(in: CGRect(origin: CGPoint(x: 296,y: 150), size: CGSize(width: 4.0, height: 4.0)))

            
            // move to the center of the pie chart
            ctx?.move(to: viewCenter)
            var xQuadrant = 150;
            var yQuadrant = 150;
//            if ((index+1)%2 == 0){
//                xQuadrant = xQuadrant * -1;
//                yQuadrant = yQuadrant * -1;
//            }
            var corX = CGFloat(xQuadrant) + (radius *  cos(CGFloat(index+1) * (3.14/8)))
            var corY = CGFloat(yQuadrant) + (radius * sin(CGFloat(index+1) * (3.14/8)))
            
            cordinate.append(CGPoint(x:corX,y:corY))
            print( (radius *  cos(CGFloat(index+1) * (3.14/8))),(radius * sin(CGFloat(index+1) * (3.14/8))), (index+2)%2)
            
            
            
            ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            ctx?.addEllipse(in: CGRect(origin: CGPoint(x: corX,y: corY), size: CGSize(width: 4.0, height: 4.0)))
            
            ctx?.strokePath();
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
            let imageView1 = UIImageView(image: segment.img)
            imageView1.frame = CGRect(x: corX - 15, y: corY - 15, width: 30, height: 30)
            self.addSubview(imageView1)
            imageView?.backgroundColor = UIColor.red
            
        }
    }


}
