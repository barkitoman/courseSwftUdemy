//
//  EditViewController.swift
//  PersistenciaCD_BD
//
//  Created by Juian Barco on 10/3/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    var studentEdit : Students!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var isActive: UISwitch!
    
    func context() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = studentEdit.name
        ageText.text = "\(studentEdit.age)"
        addressText.text = studentEdit.address
        isActive.isOn = studentEdit.active ? true : false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func edit(_ sender: UIButton) {
        let cont = context()
        guard let age = Int16(ageText.text!) else { return }
        studentEdit.setValue(nameText.text, forKey: "name")
        studentEdit.setValue(age, forKey: "age")
        studentEdit.setValue(addressText.text, forKey: "address")
        studentEdit.setValue(isActive.isOn, forKey: "active")
        
        do{
            try cont.save()
            navigationController?.popViewController(animated: true)
        }catch let error as NSError{
            print("Error in save of edit", error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
