//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by Markus Eriksson on 2017-12-21.
//  Copyright © 2017 Markus Eriksson. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var destinationViewController = segue.destination
        
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {
                faceViewController.expression = expression
            faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> =
    [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "neutral" : FacialExpression(eyes: .closed, mouth: .neutral)
    ]
 

}
