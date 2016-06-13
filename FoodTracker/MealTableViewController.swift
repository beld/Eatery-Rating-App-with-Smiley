import UIKit

class MealTableViewController: UITableViewController {
    
    var user: User?
    var startTime: CFAbsoluteTime!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem?.title = "Bearbeiten"
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.df_setBackgroundColor(UIColor.clearColor())
        
        let imageView = UIImageView(image: UIImage(named: "healthy-foods"))
        imageView.contentMode = .ScaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width * 0.5)
        tableView.tableHeaderView = imageView
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = user!.meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.floatRatingView.rating = (meal.tasteRating + meal.healthRating) / 2
        cell.floatRatingView.editable = false
        cell.rating.text = String(format: "%.1f", cell.floatRatingView.rating)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if navigationItem.rightBarButtonItem?.title == "Done" {
            navigationItem.rightBarButtonItem?.title = "Bestätigen"
        } else if navigationItem.rightBarButtonItem?.title == "Edit" {
            navigationItem.rightBarButtonItem?.title = "Bearbeiten"
        }
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            user!.meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = user!.meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
            startTime = CFAbsoluteTimeGetCurrent()
        }
        else if segue.identifier == "AddItem" {
            print("Adding a new meal")
        }
        else if saveButton === sender {
            let userListTableViewController = segue.destinationViewController as! UserListTableViewController
            userListTableViewController.tableView.reloadData()
        }
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let elapsedTime = CFAbsoluteTimeGetCurrent() - startTime
                meal.elapsedRatingTime = elapsedTime
                // updating existing meal
                user!.meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                // reset navigation bar to transparent
                self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor().colorWithAlphaComponent(0))
                navigationController!.navigationBar.tintColor = UIColor.whiteColor()
                navigationController!.navigationBar.titleTextAttributes =
                    ([NSFontAttributeName: UIFont(name: "ChalkboardSE-Regular", size: 17)!,
                        NSForegroundColorAttributeName: UIColor.whiteColor()])
            }
            else {
                // Add a new meal
                let newIndexPath = NSIndexPath(forRow: user!.meals.count, inSection: 0)
                user!.meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let color = UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1)
        let offsetY = scrollView.contentOffset.y
        let prelude: CGFloat = 90
        if offsetY >= -64 {
            let alpha = min(1, ( offsetY) / (64 + prelude))
            self.navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(alpha))
        }
    }
}
