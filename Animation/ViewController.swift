//
//  ViewController.swift
//  Animation
//
//  Created by Mostafa AbdEl Fatah on 10/20/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cardView: UIView!
    var isFaceUp:Bool = false {
        didSet{
            if isFaceUp {
                cardView.backgroundColor = UIColor.random()
                label.text = 100.randomString
            }else{
                cardView.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
                label.text = ""
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
    }
    
    @IBAction func viewTabbed(_ sender: UITapGestureRecognizer) {
        
        if !isFaceUp {
            switch sender.state {
            case .ended:
                flipCardView {
                    self.scaleCardView(scale: 2.0, completion: {
                        self.scaleCardView(scale: 0.1, completion: {
                            self.scaleCardView(scale: 1.0, completion: nil)
                        })
                    })
                }
                
            default:
                break
            }
        }else {
            switch sender.state {
            case .ended:
                flipCardView(completion: nil)
            default:
                break
        }
    }
    
}
    
    /// flip CardView Animation
    
    private func flipCardView(completion: (()->Void)? ){
        UIView.transition(
            with: self.cardView
            , duration: 1.0
            , options: [.transitionFlipFromLeft]
            , animations: {
                self.isFaceUp = !self.isFaceUp
        }
            , completion:{ (complete) in if completion != nil {completion!()}}
        )
    }
    
    private func scaleCardView(scale:CGFloat, completion: (()->Void)?){
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0,
            options: [],
            animations: {
                self.cardView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            },
            completion: {position in if completion != nil {completion!()} }
        )
    }
    
}










