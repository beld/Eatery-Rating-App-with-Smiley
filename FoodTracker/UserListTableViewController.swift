//
//  NameListViewController.swift
//  Eatery Star
//
//  Created by Ding on 5/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import SCLAlertView
import M13Checkbox
import RainbowNavigation
import MessageUI
var mailString = NSMutableString()

class UserListTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate, MFMailComposeViewControllerDelegate {
    
    var users = [User]()
    let ageRange = Array(10...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.leftBarButtonItem?.title = "Bearbeiten"
        view.backgroundColor = UIColor.cyanColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.df_setBackgroundColor(UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.0))
        self.navigationController?.navigationBar.df_setStatusBarMaskColor(UIColor(white: 0, alpha: 0.0))
        
        let imageView = UIImageView(image: UIImage(named: "user-profile-bg"))
        imageView.contentMode = UIViewContentMode.Redraw
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width * 0.3)
        tableView.tableHeaderView = imageView
        
        if let savedUsers = loadUsers() {
            users += savedUsers
        } else {
            users += loadSampleUsers()
        }
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if navigationItem.leftBarButtonItem?.title == "Done" {
            navigationItem.leftBarButtonItem?.title = "Bestätigen"
        } else {
            navigationItem.leftBarButtonItem?.title = "Bearbeiten"
        }
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print("aaaaa")
        if editingStyle == .Delete {
            // Delete the row from the data source
            users.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveUsers()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @IBAction func addUser(sender: AnyObject) {
        let alert = customAlert()
        alert.showInfo("Anmeldung", subTitle: "")
    }
    
    func customAlert() -> SCLAlertView {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRectMake(0,0,300,350))
        
        // Add textfield 1 for user ID
        let textfield1 = UITextField(frame: CGRectMake(10,10,190,25))
        textfield1.layer.borderColor = UIColor.greenColor().CGColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Benutzer ID"
        textfield1.textAlignment = NSTextAlignment.Center
        textfield1.keyboardType = .NumberPad
        textfield1.delegate = self
        subview.addSubview(textfield1)
        
        let maleLabel = UILabel(frame: CGRectMake(10,textfield1.frame.maxY + 10,25,25))
        maleLabel.text = "♂:"
        subview.addSubview(maleLabel)
        
        let maleCheckbox = M13Checkbox(frame: CGRectMake(maleLabel.frame.maxX+5,textfield1.frame.maxY + 10,25,25))
        maleCheckbox.stateChangeAnimation = .Expand(.Fill)
        subview.addSubview(maleCheckbox)
        
        let femaleLabel = UILabel(frame: CGRectMake(maleCheckbox.frame.maxX + 60,textfield1.frame.maxY + 10,25,25))
        femaleLabel.text = "♀:"
        subview.addSubview(femaleLabel)
        
        let femaleCheckbox = M13Checkbox(frame: CGRectMake(femaleLabel.frame.maxX+5,textfield1.frame.maxY + 10,25,25))
        femaleCheckbox.stateChangeAnimation = .Expand(.Fill)
        subview.addSubview(femaleCheckbox)
        
        let ageLabel = UILabel(frame: CGRectMake(10,maleLabel.frame.maxY + 10,200,25))
        ageLabel.text = "Bitte wählen Sie Ihr Alter:"
        subview.addSubview(ageLabel)
        
        let agePicker = UIPickerView(frame: CGRectMake(10,ageLabel.frame.maxY,180,125))
        agePicker.delegate = self
        agePicker.dataSource = self
        subview.addSubview(agePicker)
        
        let askLabel = UILabel(frame: CGRectMake(5,agePicker.frame.maxY,210, 70))
        askLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        askLabel.numberOfLines = 3
        askLabel.font = UIFont(name: askLabel.font.fontName, size: 14)
        askLabel.text = "* Diese Studie findet zu wissenschaftlichen Forschungszwecken statt."
        subview.addSubview(askLabel)
        
        let agreeCheckbox = M13Checkbox(frame: CGRectMake(5, askLabel.frame.maxY,14,14))
        agreeCheckbox.stateChangeAnimation = .Expand(.Fill)
        subview.addSubview(agreeCheckbox)
        
        let agreeLabel = UILabel(frame: CGRectMake(agreeCheckbox.frame.maxX + 5,askLabel.frame.maxY-5,200,25))
        agreeLabel.font = UIFont(name: agreeLabel.font.fontName, size: 14)
        agreeLabel.text = "Ich weiß, und ich stimme zu."
        subview.addSubview(agreeLabel)
        
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        alert.addButton("Anmeldung") {
            if textfield1.text!.isEmpty
                || (maleCheckbox.checkState == .Unchecked && femaleCheckbox.checkState == .Unchecked)
                || (maleCheckbox.checkState == .Checked && femaleCheckbox.checkState == .Checked || agreeCheckbox.checkState == .Unchecked) {
                let alertWithSubtitle = self.customAlert()
                alertWithSubtitle.showError("Bitte überprüfe!", subTitle: "")
            } else {
                let ID = Int32(textfield1.text!)!
                let selectedValue = self.ageRange[agePicker.selectedRowInComponent(0)]
                let age = Int32(selectedValue)
                let gender: String
                if maleCheckbox.checkState == .Unchecked {
                    gender = "Weiblich"
                } else {
                    gender = "Männlich"
                }
                let user = User(ID : ID,  age: age, gender : gender)
                self.users.append(user!)
                self.saveUsers()
                self.tableView.reloadData()
            }
        }
        
        alert.addButton("Abbruch") {
            
        }
        return alert
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageRange.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var stringArray = ageRange.map { String($0) }
        return stringArray[row]
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    func loadSampleUsers() -> [User] {
        let user1 = User(ID: 99, age: 99, gender: "Männlich")!
        
        return [user1]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "UserListTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserListTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let user = users[indexPath.row]
        
        cell.userID.text = String(user.ID)
        cell.userAge.text = String(user.age)
        cell.userGender.text = user.gender
        return cell
    }
    
    // MARK: NSCoding
    func saveUsers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: User.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save users")
        } else {
            print("Successfully saved users")
        }
    }
    
    func loadUsers() -> [User]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL.path!) as? [User]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Rate" {
            let mealTableViewController = segue.destinationViewController as! MealTableViewController
            
            if let selectedUserCell = sender as? UserListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedUserCell)!
                let selectedUser = users[indexPath.row]
                mealTableViewController.user = selectedUser
                print("passed user's meal to meal list")
            }
        }
    }
    
    @IBAction func unwindToUserList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealTableViewController {
            let user = sourceViewController.user
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // updating existing user
                users[selectedIndexPath.row] = user!
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                print("updated user")
            }
            saveUsers()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func shareFile(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            SCLAlertView().showError("Could Not Send Email", subTitle: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let criteriaInfo = "Meal Name" + "," + "Taste" + "," + "Health" + "," + "Fat" + "," +
            "Carb" + "," + "Calories" + "," + "Energy Density" + "," + "Sugar" + "," + "Vitamin" + "," +
            "Fibre" + "," + "Difficulty" + "," + "Time" + "," + "Elapsed Rating Time"
        mailString.appendString(criteriaInfo + "\n")
        for user in users {
            let userInfo = "User ID: " + String(user.ID) + "," + "User Age: " + String(user.age) + "," + String(user.gender)
            mailString.appendString(userInfo + "\n")
            for meal in user.meals {
                var mealInfo = meal.name + ","
                mealInfo += String(meal.tasteRating) + ","
                mealInfo += String(meal.healthRating) + ","
                mealInfo += String(meal.fatRating) + ","
                mealInfo += String(meal.carbRating) + ","
                mealInfo += String(meal.caloryRating) + ","
                mealInfo += String(meal.energyDensityRating) + ","
                mealInfo += String(meal.sugarRating) + ","
                mealInfo += String(meal.vitaminRating) + ","
                mealInfo += String(meal.fibreRating) + ","
                mealInfo += String(meal.difficultyRating) + ","
                mealInfo += String(meal.timeRating) + ","
                mealInfo += String(meal.elapsedRatingTime)
                mailString.appendString(mealInfo + "\n")
            }
        }
        
        let data = mailString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        // Unwrapping the optional.
        if let content = data {
            print("NSData: \(content)")
        }
        
        let emailController = MFMailComposeViewController()
        emailController.mailComposeDelegate = self
        emailController.setSubject("CSV File")
        emailController.setMessageBody("", isHTML: false)
        
        // Attaching the .CSV file to the email.
        emailController.addAttachmentData(data!, mimeType: "text/csv", fileName: "User Data.csv")
        
        return emailController
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
