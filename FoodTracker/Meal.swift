import UIKit

class Meal: NSObject, NSCoding{
    
    var name: String
    var photo: UIImage?
    var tasteRating: Float
    var healthRating: Float
    var fatRating: Float
    var carbRating: Float
    var caloryRating: Float
    var energyDensityRating: Float
    var sugarRating: Float
    var vitaminRating: Float
    var fibreRating: Float
    var difficultyRating: Float
    var timeRating: Float
    var cookingDescription: String
    var elapsedRatingTime: Double
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, tasteRating: Float, healthRating: Float, fatRating: Float, carbRating: Float, caloryRating: Float, energyDensityRating: Float, sugarRating: Float, vitaminRating: Float, fibreRating: Float, difficultyRating: Float, timeRating: Float, cookingDescription: String, elapsedRatingTime: Double) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.tasteRating = tasteRating
        self.healthRating = healthRating
        self.fatRating = fatRating
        self.carbRating = carbRating
        self.caloryRating = caloryRating
        self.energyDensityRating = energyDensityRating
        self.sugarRating = sugarRating
        self.vitaminRating = vitaminRating
        self.fibreRating = fibreRating
        self.difficultyRating = difficultyRating
        self.timeRating = timeRating
        self.cookingDescription = cookingDescription
        self.elapsedRatingTime = elapsedRatingTime
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || tasteRating < 0 || healthRating < 0 || cookingDescription.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(photo, forKey: "photo")
        aCoder.encodeFloat(tasteRating, forKey: "tasteRating")
        aCoder.encodeFloat(healthRating, forKey: "healthRating")
        aCoder.encodeFloat(fatRating, forKey: "fatRating")
        aCoder.encodeFloat(carbRating, forKey: "carbRating")
        aCoder.encodeFloat(caloryRating, forKey: "caloryRating")
        aCoder.encodeFloat(energyDensityRating, forKey: "energyDensityRating")
        aCoder.encodeFloat(sugarRating, forKey: "sugarRating")
        aCoder.encodeFloat(vitaminRating, forKey: "vitaminRating")
        aCoder.encodeFloat(fibreRating, forKey: "fibreRating")
        aCoder.encodeFloat(difficultyRating, forKey: "difficultyRating")
        aCoder.encodeFloat(timeRating, forKey: "timeRating")
        aCoder.encodeObject(cookingDescription, forKey: "cookingDescription")
        aCoder.encodeDouble(elapsedRatingTime, forKey: "elapsedRatingTime")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let photo = aDecoder.decodeObjectForKey("photo") as? UIImage
        let tasteRating = aDecoder.decodeFloatForKey("tasteRating")
        let healthRating = aDecoder.decodeFloatForKey("healthRating")
        let fatRating = aDecoder.decodeFloatForKey("fatRating")
        let carbRating = aDecoder.decodeFloatForKey("carbRating")
        let caloryRating = aDecoder.decodeFloatForKey("caloryRating")
        let energyDensityRating = aDecoder.decodeFloatForKey("energyDensityRating")
        let sugarRating = aDecoder.decodeFloatForKey("sugarRating")
        let vitaminRating = aDecoder.decodeFloatForKey("vitaminRating")
        let fibreRating = aDecoder.decodeFloatForKey("fibreRating")
        let difficultyRating = aDecoder.decodeFloatForKey("difficultyRating")
        let timeRating = aDecoder.decodeFloatForKey("timeRating")
        let cookingDescription = aDecoder.decodeObjectForKey("cookingDescription") as! String
        let elapsedRatingTime = aDecoder.decodeDoubleForKey("elapsedRatingTime")
        
        self.init(name: name, photo: photo, tasteRating: tasteRating, healthRating: healthRating,fatRating: fatRating, carbRating: carbRating, caloryRating: caloryRating, energyDensityRating: energyDensityRating, sugarRating: sugarRating, vitaminRating: vitaminRating, fibreRating: fibreRating, difficultyRating: difficultyRating, timeRating: timeRating , cookingDescription: cookingDescription, elapsedRatingTime: elapsedRatingTime)
    }
    
}