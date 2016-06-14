//
//  EmojiRatingViewController.swift
//  FoodTracker
//
//  Created by Ding on 3/24/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import TTGEmojiRate

protocol Delegate: class {
    func didPressSaveButton(ratingValue: Float) -> Bool
}

class EmojiRatingViewController: UIViewController{

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var emojiRateView: EmojiRateView!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    
    weak var delegate: Delegate?
    var ratingContent: String!
    var ratingValue: Float = 3.0
    var ratingContentInfo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        emojiRateView.rateValue = self.ratingValue
        self.ratingLabel.text = String(format: "%.1f / 5.0", self.ratingValue)
        emojiRateView.rateValueChangeCallback = {(rateValue: Float) -> Void in
            let roundRateValue = round(rateValue * 2) / 2
            self.ratingValue = roundRateValue
            self.ratingLabel.text = String(format: "%.1f / 5.0", self.ratingValue)
        }
        self.navigationController!.navigationBar.topItem!.title = ""
        self.ratingInfoLabel.text = ratingContentInfo
    }
    
    @IBAction func saveRating(sender: AnyObject) {
        if let success = delegate?.didPressSaveButton(ratingValue) where success {
            print("Rating Saved!")
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
