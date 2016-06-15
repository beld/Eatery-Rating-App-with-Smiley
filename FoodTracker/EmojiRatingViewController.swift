//
//  EmojiRatingViewController.swift
//  FoodTracker
//
//  Created by Ding on 3/24/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import TTGEmojiRate
import SCLAlertView

protocol Delegate: class {
    func didPressSaveButton(ratingValue: Float) -> Bool
}

class EmojiRatingViewController: UIViewController{

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var emojiRateView: EmojiRateView!
    
    weak var delegate: Delegate?
    var ratingContent: String!
    var ratingValue: Float = 3.0
    var ratingContentInfo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // opposite direction, large is bad
        if ratingContent == "Fett" || ratingContent == "Kohlenhydrate" || ratingContent == "Kalorien"
        || ratingContent == "Energiedichte" || ratingContent == "Zeit" || ratingContent == "Zucker"
        || ratingContent == "Schwierigkeit" {
            emojiRateView.rateValue = 5 - self.ratingValue
            emojiRateView.rateValueChangeCallback = {(rateValue: Float) -> Void in
                let roundRateValue = round((5 - rateValue) * 2) / 2
                self.ratingValue = roundRateValue
                self.ratingLabel.text = String(format: "%.1f / 5.0", self.ratingValue).stringByReplacingOccurrencesOfString(".", withString: ",")
            }
        } else {
            emojiRateView.rateValue = self.ratingValue
            emojiRateView.rateValueChangeCallback = {(rateValue: Float) -> Void in
                let roundRateValue = round(rateValue * 2) / 2
                self.ratingValue = roundRateValue
                self.ratingLabel.text = String(format: "%.1f / 5.0", self.ratingValue).stringByReplacingOccurrencesOfString(".", withString: ",")
            }
        }
        self.ratingLabel.text = String(format: "%.1f / 5.0", self.ratingValue).stringByReplacingOccurrencesOfString(".", withString: ",")
        self.navigationController!.navigationBar.topItem!.title = ""
    }
    
    @IBAction func infoBox(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("", subTitle: ratingContentInfo, closeButtonTitle: "Bestätigen", duration: 10)
    }
    
    @IBAction func saveRating(sender: AnyObject) {
        if let success = delegate?.didPressSaveButton(ratingValue) where success {
            print("Rating Saved!")
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
