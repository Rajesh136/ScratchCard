//
//  ScratchCard.swift
//  ScratchCard
//
//  Created by techno krishna on 06/04/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import UIKit

class ScratchCard:UIView {
    
    private lazy var contentImageView:UIImageView = {
        let img:UIImageView = UIImageView(frame: self.bounds)
        img.image = #imageLiteral(resourceName: "image")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var maskImageView: UIImageView = {
        let img:UIImageView = UIImageView(frame: self.bounds)
        img.image = #imageLiteral(resourceName: "mask")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private var lastPoint:CGPoint?
    private var lineType:CGLineCap = .round
    private var lineWidth:CGFloat = 30.0

    override func awakeFromNib() {
        super.awakeFromNib()
        commoninit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    
    private func commoninit() {
        addSubview(contentImageView)
        addSubview(maskImageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lastPoint = touch.location(in: maskImageView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let point = lastPoint else { return }
        let currentLocation = touch.location(in: self)
        eraseBetween(fromPoint: point, currentPoint: currentLocation)
        lastPoint = currentLocation

    }
    
    func eraseBetween(fromPoint: CGPoint, currentPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        maskImageView.image?.draw(in: self.bounds)
        
        let path = CGMutablePath()
        path.move(to: fromPoint)
        path.addLine(to: currentPoint)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setShouldAntialias(true)
        context.setLineCap(lineType)
        context.setLineWidth(lineWidth)
        context.setBlendMode(.clear)
        context.addPath(path)
        context.strokePath()
        
        maskImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }

    
}
