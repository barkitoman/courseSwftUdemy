//
//  ShowPictureViewController.swift
//  Notes
//
//  Created by Juian Barco on 10/10/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData
class ShowPictureViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    var imageNote:Images!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imagen = imageNote.image {
            picture.image = UIImage(data: imagen as Data)
        }
        
        let buttomTrash  = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePicture))
        navigationItem.rightBarButtonItem = buttomTrash
    }
    
    @objc func deletePicture(){
        let context = ConnectionCoreData().context()
        let fetchRequest: NSFetchRequest<Images> = Images.fetchRequest()
        let id = imageNote.id
        fetchRequest.predicate = NSPredicate(format: "id == %@", id! as CVarArg)
        
        do{
            let result = try context.fetch(fetchRequest)
            for res in result {
                context.delete(res)
            }
            try context.save()
            navigationController?.popViewController(animated: true)
            print("Eliminoo....")
        }catch let error as NSError {
            print("Error Deleting image", error.localizedDescription)
        }
    }


}
