//
//  User.swift
//  Eatery Star
//
//  Created by Ding on 5/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding{
    
    var ID: Int32
    var age: Int32
    var gender: String
    var meals = [Meal]()
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("users")
    
    // MARK: Initialization
    
    init?(ID: Int32, age: Int32, gender: String, meals: [Meal]) {
        // Initialize stored properties.
        self.ID = ID
        self.age = age
        self.gender = gender
        self.meals = meals
        
        super.init()
        
        // Initialization should fail
        if ID < 0 || ID == 0 || age == 0 || age < 0 || gender.isEmpty {
            return nil
        }
    }
    
    var meal1 = Meal(name: "Capresesalat", photo: UIImage(named: "meal1"), tasteRating: 0.0, healthRating: 0.0, fatRating: 0.0, carbRating: 0.0, caloryRating: 0.0, energyDensityRating: 0.0, sugarRating: 0.0, vitaminRating: 0.0, fibreRating: 0.0, difficultyRating: 0.0, timeRating: 0.0, cookingDescription: "Caprese (italienisch für zu Capri gehörend) ist ein italienischer Vorspeisensalat aus Tomaten, Mozzarella, Basilikum und Olivenöl. Wegen seiner Farben Rot, Weiß und Grün, die der Flagge Italiens entsprechen, gilt er als Nationalgericht.", elapsedRatingTime: 0.0)!
    
    var meal2 = Meal(name: "Kartoffeln und Hähnchen aus dem Ofen", photo: UIImage(named: "meal2")!, tasteRating: 0.0, healthRating: 0.0, fatRating: 0.0, carbRating: 0.0, caloryRating: 0.0, energyDensityRating: 0.0, sugarRating: 0.0, vitaminRating: 0.0, fibreRating: 0.0, difficultyRating: 0.0, timeRating: 0.0,cookingDescription: "1. Kartoffeln schälen und vierteln, auf einem Blech verteilen, mit den Gewürzen und dem Öl mischen. 2. Hähnchen sauber machen, abwaschen, trocken tupfen und mit Vegeta einreiben, auf den Kartoffeln verteilen. Backofen auf 250° vorheizen und das ganze 1 Stunde backen (Nach 30min wenden)", elapsedRatingTime: 0.0)!
    var meal3 = Meal(name: "Spaghetti mit Fleischbällchen", photo: UIImage(named: "meal3")!, tasteRating: 0.0, healthRating: 0.0, fatRating: 0.0, carbRating: 0.0, caloryRating: 0.0, energyDensityRating: 0.0, sugarRating: 0.0, vitaminRating: 0.0, fibreRating: 0.0, difficultyRating: 0.0, timeRating: 0.0,cookingDescription: "Für die Spaghetti mit Fleischbällchen das Faschierte in eine Schüssel geben. Salz, Pfeffer und Oregano dazugeben und mit nassen Händen zu einem glatten Fleischteig verkneten. Kleine Stückchen vom Teig abnehmen und zwischen den Händen zu ca. 20 kleinen runden Fleischbällchen formen. Anschließend die Zwiebel schälen und in feine Würfel schneiden. Das Olivenöl in einer beschichteten Pfanne warm werden lassen. Die Fleischbällchen in die Pfanne geben und von allen Seiten 10 Minuten anbraten. Dann die Zwiebel dazugeben und kurz glasig dünsten. Die geschälten Tomaten zugeben, mit Zucker, Salz und Pfeffer würzen. Bei kleiner Hitze 10 Minuten köcheln lassen. Die Spaghetti mit der Fleischbällchen-Sauce vermischen und auf die Teller verteilen. Mit Basilikum servieren.", elapsedRatingTime: 0.0)!
    var spaghetti = Meal(name: "Spaghetti mit Tomatensoße", photo: UIImage(named: "Spaghetti")!, tasteRating: 0.0, healthRating: 0.0, fatRating: 0.0, carbRating: 0.0, caloryRating: 0.0, energyDensityRating: 0.0, sugarRating: 0.0, vitaminRating: 0.0, fibreRating: 0.0, difficultyRating: 0.0, timeRating: 0.0, cookingDescription: "Spaghetti in einem Topf mit Salzwasser 10-12 Minuten bzw. nach Packungsanleitung al dente kochen. Öl in einem großen Topf bei mittlerer Temperatur erhitzen und Knoblauch darin anbraten. Häufig rühren, bis der Knoblauch Farbe annimmt. Tomaten, Salz und Pfeffer dazugeben und ca. 10 Minuten kochen. Basilikum die letzten 2 Minuten mitkochen. Spaghetti abgießen und in den Topf mit der Tomatensoße geben. Gut vermischen und mit Parmesan bestreut servieren.", elapsedRatingTime: 0.0)
    var semmel = Meal(name: "Leberkäse-Semmel", photo: UIImage(named: "Semmel")!, tasteRating: 0.0, healthRating: 0.0, fatRating: 0.0, carbRating: 0.0, caloryRating: 0.0, energyDensityRating: 0.0, sugarRating: 0.0, vitaminRating: 0.0, fibreRating: 0.0, difficultyRating: 0.0, timeRating: 0.0, cookingDescription: "Für die Leberkäsesemmel, die beiden Semmeln aufschneiden. Den Leberkäse gegebenenfalls noch sanft erhitzen, entweder im Mikrowellenherd oder in einer beschichteten Pfanne mit wenig Wasser hineinlegen. Die Essiggurkerl der Länge nach in dünne Scheiben schneiden und auf die Leberkäsesemmel legen. Den Senf auftragen und die obere Semmelhälfte darauf legen.", elapsedRatingTime: 0.0)
    
    convenience init?(ID: Int32, age: Int32, gender: String) {
        self.init(ID: ID, age: age, gender: gender, meals: [])
        self.meals = [spaghetti!, semmel!]
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt(ID, forKey: "ID")
        aCoder.encodeInt(age, forKey: "age")
        aCoder.encodeObject(gender, forKey: "gender")
        aCoder.encodeObject(meals, forKey: "meals")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let ID = aDecoder.decodeIntForKey("ID")
        let age = aDecoder.decodeIntForKey("age")
        let gender = aDecoder.decodeObjectForKey("gender") as! String
        let meals = aDecoder.decodeObjectForKey("meals") as! [Meal]
        
        self.init(ID: ID, age: age, gender: gender, meals: meals)
    }
    
}