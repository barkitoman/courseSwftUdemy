//
//  ViewController.swift
//  PersistenciaCD_BD
//
//  Created by Juian Barco on 10/3/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var isActive: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func context() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    @IBAction func save(_ sender: UIButton) {
        let cont = context()
        let entityStudents = NSEntityDescription.insertNewObject(forEntityName: "Students", into: cont) as! Students
        entityStudents.name = nameText.text
        guard let age = Int16(ageText.text!) else { return }
        entityStudents.age = age
        entityStudents.address = addressText.text
        entityStudents.active = isActive.isOn
        
        do{
            try cont.save()
            nameText.text = ""
            ageText.text = ""
            addressText.text = ""
            isActive.isOn = false
        } catch let error as NSError {
            print("Error in save", error.localizedDescription)
        }
        
    }
    
    @IBAction func show(_ sender: UIButton) { //Show Info with CoreData
        let cont = context()
        let fetchRequest : NSFetchRequest<Students> = Students.fetchRequest()
        do{
            let result = try cont.fetch(fetchRequest)
            print("Number of records: \(result.count)")
            
            for res in result as [NSManagedObject] {
                let name = res.value(forKey: "name")
                let age = res.value(forKey: "age")
                let address = res.value(forKey: "address")
                let active = res.value(forKey: "active")
                print("Name: \(name ?? "Whitout name"), Age: \(age ?? "0"), Address\(address ?? "---"), \(active ?? false)")
            }
        } catch let error as NSError {
            print("Error in show", error.localizedDescription)
        }
    }
    
    @IBAction func clearEntity(_ sender: UIButton) { //Clear CoreData
        let cont = context()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        let clear = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try cont.execute(clear)
            print("Deleted entity")
        } catch let error as NSError {
            print("Error in delete", error.localizedDescription)
        }
    }
    
    
    
}

