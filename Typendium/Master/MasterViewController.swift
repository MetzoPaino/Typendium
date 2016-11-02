//
//  MasterViewController.swift
//  Typendium
//
//  Created by William Robinson on 02/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var titleContainerViewYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sectionContainerView: UIView!
    @IBOutlet weak var sectionContainerViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var sectionContainerViewHeightConstraint: NSLayoutConstraint!
    
    let panOffset = 200.0 as CGFloat
    var panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(MasterViewController.handlePanGesture(gestureRecognizer:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        
        addOffsets()
        
        view.bringSubview(toFront: titleContainerView)
    }
    
    func addOffsets() {
        
        sectionContainerViewYConstraint.constant = panOffset
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let viewTranslation = gestureRecognizer.translation(in: view)
        let viewLocationPoint = gestureRecognizer.location(in: view)

        let parallax = panOffset / view.frame.size.height
        
        switch gestureRecognizer.state {
        case .changed:
            titleContainerViewYConstraint.constant = viewTranslation.y
            sectionContainerViewYConstraint.constant = panOffset + viewTranslation.y * parallax
        case .ended:

            
            let absoluteNumber = fabs(titleContainerViewYConstraint.constant)
            let height = self.view.frame.height / 2

            print("absoluteNumber = \(absoluteNumber) height = \(height)")
            
            if absoluteNumber < height {
                
                animateToPosition(up: false)
                
            } else {
                
                animateToPosition(up: true)
            }
            

            break
        default:
            break
        }



        //print("\(viewTranslation.y) / \(viewLocationPoint.y) \(titleContainerViewYConstraint.constant)")
        
    }
    
    func animateToPosition(up: Bool) {
        
        if up == true {
            
            self.titleContainerViewYConstraint.constant = 0 - self.view.frame.height
            self.sectionContainerViewYConstraint.constant = 0
            
        } else {
            
            self.titleContainerViewYConstraint.constant = 0
            self.sectionContainerViewYConstraint.constant = self.panOffset
        }
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
