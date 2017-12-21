//
//  ViewController.swift
//  Faceit
//
//  Created by Markus Eriksson on 2017-12-20.
//  Copyright © 2017 Markus Eriksson. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController
{

    @IBOutlet weak var faceView: FaceView!
    {
        didSet {
            
        // resize
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
        // tap
            let tapRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
        // swipe up / down
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreasehappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            //update ui
            updateUI()
        }
    }
    
    @objc func increaseHappiness()
    {
        expression = expression.happier
    }
    @objc func decreasehappiness()
    {
        expression = expression.sadder
    }
    
    @objc func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer)
    {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .open, mouth: .smirk)
    {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes
        {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        default:
            break
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures =
        [
            FacialExpression.Mouth.grin:0.5,
            .frown:-1.0,
            .smile:1.0,
            .neutral:0.0,
            .smirk:-0.5
        ]

}

