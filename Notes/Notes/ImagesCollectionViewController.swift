//
//  ImagesCollectionViewController.swift
//  Notes
//
//  Created by Juian Barco on 10/9/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class ImagesCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagesNotes = [Images]()
    var note = Notes()
    var picture : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = note.title
        let buttomCamera  = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicture))
        navigationItem.rightBarButtonItem = buttomCamera
        
        //MARK: LAYOUT-COLLECTIONVIEW
        let imageSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 1, bottom: 10, right: 1)
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        collectionView.collectionViewLayout = layout
        showImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showImages()
        collectionView.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesNotes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PictureCollectionViewCell
        let imageNote = imagesNotes[indexPath.row]
        if let imagen = imageNote.image {
            cell.picture.image = UIImage(data: imagen as Data)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPicture", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPicture" {
            let id = sender as! IndexPath
            let row = imagesNotes[id.row]
            let destination = segue.destination as! ShowPictureViewController
            destination.imageNote = row
        }
    }
    
    @objc func addPicture(){
        let alert = UIAlertController(title: "Take picture", message: "camara - gallery", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take picture", style: .default, handler: {(action) in
            self.takePicture()
        })
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: {(action) in
            self.enterGallery()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func takePicture(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func enterGallery(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let imageTook = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picture = imageTook
        let contexto = ConnectionCoreData().context()
        let entityImages = NSEntityDescription.insertNewObject(forEntityName: "Images", into: contexto) as! Images
        entityImages.id = UUID()
        entityImages.id_note = note.id
        let dataImage = picture.pngData()
        entityImages.image = dataImage
        note.mutableSetValue(forKey: "relationToImages").add(entityImages)
        do{
            try contexto.save()
            print("Save image")
            self.showImages()
            self.collectionView.reloadData()
        }catch let error as NSError {
            print("Error in save image", error.localizedDescription)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showImages(){
        let context = ConnectionCoreData().context()
        let fetchRequest: NSFetchRequest<Images> = Images.fetchRequest()
        let id = note.id
        fetchRequest.predicate = NSPredicate(format: "id_note == %@", id! as CVarArg)
        
        do{
            imagesNotes = try context.fetch(fetchRequest)
        }catch let error as NSError {
            print("Error in load images...", error.localizedDescription)
        }
    }

}
