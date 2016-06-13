import UIKit
import AMTagListView
import TTGEmojiRate

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Delegate {
    
    // MARK: Properties
    var meal: Meal?
    var currImage: UIImage?
    let ratingContents = ["Gesundheit", "Geschmack", "Kalorien", "Energiedichte", "Fett", "Kohlenhydrate", "Schwierigkeit", "Zeit", "Vitamine", "Zucker", "Ballaststoffe"]
    let dict : [String : String] = [
        "Gesundheit" : "Wie gesund ist diese Gericht in Ihrer Meinung, von 0 bis 5",
        "Geschmack": "Bitte den Geschmack diese Gericht nach Ihren Gunsten bewerten, von 0 bis 5",
        "Kalorien" : "Bitte bewerten Sie die Kalorien dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Energiedichte" : "Bitte bewerten Sie die Energiedichte (Kilokalorien pro Gramm) dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Fett" : "Bitte bewerten Sie das Fett dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Kohlenhydrate" : "Bitte bewerten Sie das Kohlenhydrat dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Schwierigkeit": "Bitte bewerten Sie den Schwierigkeitsgrad dieses Mahl zu bereiten, von 0 bis 5",
        "Zeit": "Bitte bewerten Sie die Zeit, die Sie brauchen diese Mahlzeit zu bereiten, von 0 bis 5",
        "Vitamine": "Bitte bewerten Sie die Vitamine dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Zucker": "Bitte bewerten Sie den Zucker dieses Gericht Ihrer Meinung nach, von 0 bis 5",
        "Ballaststoffe": "Bitte bewerten Sie die Ballaststoffe dieses Gericht Ihrer Meinung nach, von 0 bis 5"
    ]
    var currentRatingValue: Float!
    var currentRatingContent: String = ""
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var diffcultyLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var energyDensityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloryLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var vitaminLabel: UILabel!
    @IBOutlet weak var fibreLabel: UILabel!
    @IBOutlet weak var tagListView: AMTagListView!
    @IBOutlet weak var tasteEmojiView: EmojiRateView!
    @IBOutlet weak var healthEmojiView: EmojiRateView!
    @IBOutlet weak var fatEmojiView: EmojiRateView!
    @IBOutlet weak var carbEmojiView: EmojiRateView!
    @IBOutlet weak var caloryEmojiView: EmojiRateView!
    @IBOutlet weak var energyDensityEmojiView: EmojiRateView!
    @IBOutlet weak var difficultyEmojiView: EmojiRateView!
    @IBOutlet weak var timeEmojiView: EmojiRateView!
    @IBOutlet weak var sugarEmojiView: EmojiRateView!
    @IBOutlet weak var vitaminEmojiView: EmojiRateView!
    @IBOutlet weak var fibreEmojiView: EmojiRateView!
    
    
    @IBAction func addTag(sender: AnyObject) {
        let tag = ["lecker", "gesund", "einfach", "schnell"]
        RRTagController.displayTagController(self, tagsString: tag, blockFinish: { (selectedTags, unSelectedTags) -> () in
            // the user finished the selection and returns the separated list Selected and not selected.
            for tag in selectedTags {
                self.tagListView.addTag(tag.textContent)
            }
        }) { () -> () in
            // here the user cancel the selection, nothing is returned.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1))
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes =
            ([NSFontAttributeName: UIFont(name: "BradleyHandITCTT-Bold", size: 15)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // set up views if editing an existing meal
        if let existingMeal = meal {
            navigationItem.title = existingMeal.name
            nameTextField.text = existingMeal.name
            photoImageView.image = existingMeal.photo
            
            tasteLabel.text = String(format: "%.1f / 5.0", meal!.tasteRating)
            tasteEmojiView.rateValue = (meal?.tasteRating)!

            healthLabel.text = String(format: "%.1f / 5.0", meal!.healthRating)
            healthEmojiView.rateValue = (meal?.healthRating)!
         
            fatLabel.text = String(format: "%.1f / 5.0", meal!.fatRating)
            fatEmojiView.rateValue = (meal?.fatRating)!

            carbLabel.text = String(format: "%.1f / 5.0", meal!.carbRating)
            carbEmojiView.rateValue = (meal?.carbRating)!
           
            caloryLabel.text = String(format: "%.1f / 5.0", meal!.caloryRating)
            caloryEmojiView.rateValue = (meal?.caloryRating)!
          
            energyDensityLabel.text = String(format: "%.1f / 5.0", meal!.energyDensityRating)
            energyDensityEmojiView.rateValue = (meal?.energyDensityRating)!
        
            diffcultyLabel.text = String(format: "%.1f / 5.0", meal!.difficultyRating)
            difficultyEmojiView.rateValue = (meal?.difficultyRating)!
            
            timeLabel.text = String(format: "%.1f / 5.0", meal!.timeRating)
            timeEmojiView.rateValue = (meal?.timeRating)!
            
            sugarLabel.text = String(format: "%.1f / 5.0", meal!.sugarRating)
            sugarEmojiView.rateValue = (meal?.sugarRating)!
            
            vitaminLabel.text = String(format: "%.1f / 5.0", meal!.vitaminRating)
            vitaminEmojiView.rateValue = (meal?.vitaminRating)!
            
            fibreLabel.text = String(format: "%.1f / 5.0", meal!.fibreRating)
            fibreEmojiView.rateValue = (meal?.fibreRating)!
         
            descriptionTextView.text = existingMeal.cookingDescription
        }
        
        tasteEmojiView.rateDragSensitivity = 0
        healthEmojiView.rateDragSensitivity = 0
        fatEmojiView.rateDragSensitivity = 0
        carbEmojiView.rateDragSensitivity = 0
        caloryEmojiView.rateDragSensitivity = 0
        energyDensityEmojiView.rateDragSensitivity = 0
        difficultyEmojiView.rateDragSensitivity = 0
        timeEmojiView.rateDragSensitivity = 0
        sugarEmojiView.rateDragSensitivity = 0
        vitaminEmojiView.rateDragSensitivity = 0
        fibreEmojiView.rateDragSensitivity = 0
        
        descriptionTextView.sizeToFit()
        
        // enable save button only if text field has valid name
        checkValidMealName()
        
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1)
        tagListView.addTag("food")
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // disable the save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // depending on style of presentation (modal or push), this view
        // controller needs to be dismissed in 2 different ways
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    // configure a view controller before it's passed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
        }
        for content in ratingContents {
            if(segue.identifier == content) {
                let destinationViewController = segue.destinationViewController as! EmojiRatingViewController
                destinationViewController.ratingContent = content
                destinationViewController.delegate = self
                self.currentRatingContent = content
                destinationViewController.navigationItem.title = content
                destinationViewController.ratingContentInfo = self.dict[content]
            }
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func update() {
        switch currentRatingContent {
            case "Geschmack":
                meal!.tasteRating = currentRatingValue
                tasteLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                tasteEmojiView.rateValue = (meal?.tasteRating)!
           case "Gesundheit":
                meal!.healthRating = currentRatingValue
                healthLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                healthEmojiView.rateValue = (meal?.healthRating)!
            case "Kalorien":
                 meal!.caloryRating = currentRatingValue
                caloryLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                caloryEmojiView.rateValue = (meal?.caloryRating)!
            case "Energiedichte":
                meal!.energyDensityRating = currentRatingValue
                energyDensityLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                energyDensityEmojiView.rateValue = (meal?.energyDensityRating)!
           case "Fett":
                meal!.fatRating = currentRatingValue
                fatLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                fatEmojiView.rateValue = (meal?.fatRating)!
            case "Kohlenhydrate":
                meal!.carbRating = currentRatingValue
                carbLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                carbEmojiView.rateValue = (meal?.carbRating)!
           case "Schwierigkeit":
                meal!.difficultyRating = currentRatingValue
                diffcultyLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                difficultyEmojiView.rateValue = (meal?.difficultyRating)!
            case "Zeit":
                meal!.timeRating = currentRatingValue
                timeLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                timeEmojiView.rateValue = (meal?.timeRating)!
            case "Zucker":
                meal!.sugarRating = currentRatingValue
                sugarLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                sugarEmojiView.rateValue = (meal?.sugarRating)!
            case "Vitamine":
                meal!.vitaminRating = currentRatingValue
                vitaminLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                vitaminEmojiView.rateValue = (meal?.vitaminRating)!
            case "Ballaststoffe":
                meal!.fibreRating = currentRatingValue
                fibreLabel.text = String(format: "%.1f / 5.0", currentRatingValue)
                fibreEmojiView.rateValue = (meal?.fibreRating)!
            default: break
        }
    }
    
    func didPressSaveButton(currentRatingValue: Float) -> Bool {
        self.currentRatingValue = currentRatingValue
        update()
        return true
    }
}
