//
//  ViewController.swift
//  BezierDemo
//
//  Created by Appinventiv on 04/04/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var demoView: RectView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.demoView.isHidden = true
        let nView = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        nView.backgroundColor = .green
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        self.demoView.isHidden = sender.isSelected
//        sender.isSelected = !sender.isSelected
        
        let view = RectView(frame: CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y + sender.frame.height + 10, width: 100, height: 100),pointer: CGPoint(x: 10, y: 10), buttonFrame: sender.frame,pos: 0.6, direction: .bottom)
        
        self.view.addSubview(view)
        
    }
}

class Triangle: UIView{
    
}

class RectView: UIView{
    
    var pointer: CGPoint
    var btnFrame: CGRect
    var direction: Direction
    var pos: Float
    
    init(frame: CGRect, pointer: CGPoint, buttonFrame: CGRect, pos: Float, direction: Direction) {
        self.pointer = pointer
        self.btnFrame = buttonFrame
        self.direction = direction
        if direction == .top{
            self.pos = pos
        }else{
            self.pos = 1 - pos
        }
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let roundRectPath = UIBezierPath()
        
        let /*origin*/_ = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y)
        
        let size = self.frame.size
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let w = size.width
        let h = size.height
        let hw = w / 2
        let hh = h / 2
        // move to origin of the view
        roundRectPath.move(to: CGPoint(x: x, y: y))
        
        roundRectPath.addLine(to: CGPoint(x: x, y: y))
        
        switch self.direction{
        case .top:
            let top_x = w * CGFloat(pos)
            roundRectPath.addLine(to: CGPoint(x: top_x - 5, y: y))
            roundRectPath.addLine(to: CGPoint(x: top_x, y: y - 10))
            roundRectPath.addLine(to: CGPoint(x: top_x + 5, y: y))
            roundRectPath.addLine(to: CGPoint(x: w - 5, y: y))
            roundRectPath.addArc(withCenter: CGPoint(x: w-5, y: y + 5), radius: 5, startAngle: 90, endAngle: 0, clockwise: true)
            roundRectPath.addLine(to: CGPoint(x: w, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: y))
        case .right:
            let right_y = h * CGFloat(pos)
            roundRectPath.addLine(to: CGPoint(x: w, y: y))
            roundRectPath.addLine(to: CGPoint(x: w, y: right_y - 5))
            roundRectPath.addLine(to: CGPoint(x: w + 10, y: right_y))
            roundRectPath.addLine(to: CGPoint(x: w, y: right_y + 5))
            roundRectPath.addLine(to: CGPoint(x: w, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: y))
        case .bottom:
            let bottom_x = w * CGFloat(pos)
            roundRectPath.addLine(to: CGPoint(x: w, y: y))
            roundRectPath.addLine(to: CGPoint(x: w, y: h))
            roundRectPath.addLine(to: CGPoint(x: w - bottom_x - 5, y: h))
            roundRectPath.addLine(to: CGPoint(x: w - bottom_x, y: h + 10))
            roundRectPath.addLine(to: CGPoint(x: w - bottom_x + 5, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: y))
        case .left:
            let left_y = h * CGFloat(pos)
            roundRectPath.addLine(to: CGPoint(x: w, y: y))
            roundRectPath.addLine(to: CGPoint(x: w, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: h))
            roundRectPath.addLine(to: CGPoint(x: x, y: h - left_y + 5))
            roundRectPath.addLine(to: CGPoint(x: x - 10, y: h - left_y))
            roundRectPath.addLine(to: CGPoint(x: x, y: h - left_y - 5))
            roundRectPath.addLine(to: CGPoint(x: x, y: y))
        }
        roundRectPath.lineWidth = 2.0
//        roundRectPath.close()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: hw, y: hh), radius: hw / 2, startAngle: 0, endAngle: 360, clockwise: true)
        roundRectPath.append(circlePath)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = roundRectPath.cgPath
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2.0
        
        layer.addSublayer(shapeLayer)
        self.layer.cornerRadius = 3.0
    }
}

enum Direction{
    case left
    case right
    case top
    case bottom
}
