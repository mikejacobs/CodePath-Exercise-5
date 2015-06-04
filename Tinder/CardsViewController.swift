//
//  CardsViewController.swift
//  Tinder
//
//  Created by Mike Jacobs on 6/4/15.
//  Copyright (c) 2015 Mike Jacobs. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIImageView!
    var cardInitialCenter: CGPoint!
    var fadeTransition: GrowTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.clipsToBounds = true
        cardView.contentMode = .ScaleAspectFill
        cardView.userInteractionEnabled = true
        cardView.image = UIImage(named: "ryan")
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedView:"))
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedCard:"))
        cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanning:"))
        
        println("works")
        
        cardInitialCenter = cardView.center
    }
    func tappedCard(tapGestureRecognizer: UITapGestureRecognizer){
        performSegueWithIdentifier("profileSegue", sender: self)
        
    }
    func tappedView(tapGestureRecognizer: UITapGestureRecognizer){
        returnView()
    }
    
    func handlePanning(panGestureRecognizer: UIPanGestureRecognizer){
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var rotation = translation.x / 320 / 2
        
//        println("t: \(translation.x) v:\(velocity.x)")
//        println("x: \(self.cardView.frame.origin.x) y: \(self.cardView.frame.origin.y)")
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            cardView.center.y = cardInitialCenter.y + translation.y
            cardView.center.x = cardInitialCenter.x + translation.x
            cardView.transform = CGAffineTransformMakeRotation(rotation)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if(translation.x > 50 && velocity.x > 0){
                UIView.animateWithDuration(0.3){
                    self.cardView.center.x += self.view.frame.width + velocity.x
                }
            } else if (translation.x < -50 && velocity.x < 0){
                println((self.view.frame.width + velocity.x))
                UIView.animateWithDuration(0.3){
                    self.cardView.center.x -= self.view.frame.width + abs(velocity.x)
                }
            } else {
                self.returnView()
            }
        }
        
    }
    func returnView(){
        println("back to original")
        UIView.animateWithDuration(0.3){
            self.cardView.center = self.cardInitialCenter
            self.cardView.transform = CGAffineTransformIdentity
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        
        destinationViewController.image = self.cardView.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        fadeTransition = GrowTransition()
        fadeTransition.duration = 0.3
        destinationViewController.transitioningDelegate = fadeTransition
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
