//
//  GrowTransition.swift
//  
//
//  Created by Mike Jacobs on 6/4/15.
//
//

import UIKit

class GrowTransition: BaseTransition {
    
    var tempImg: UIImageView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var toVc = toViewController as! ProfileViewController
        var fromVc = fromViewController as! CardsViewController
        
        
        toVc.view.alpha = 0
        
        tempImg = UIImageView()
        tempImg.image = fromVc.cardView.image
        tempImg.frame = fromVc.cardView.frame
        tempImg.clipsToBounds = true
        tempImg.contentMode = .ScaleAspectFill
        tempImg.userInteractionEnabled = true
        
        containerView.addSubview(tempImg)
        
        UIView.animateWithDuration(duration, animations: {
            self.tempImg.frame = toVc.imageView.frame
            }) { (finished: Bool) -> Void in
                toVc.view.alpha = 1
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        var fromVc = fromViewController as! ProfileViewController
        var toVc = toViewController as! CardsViewController
        fromVc.view.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            self.tempImg.frame = toVc.cardView.frame
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
}

