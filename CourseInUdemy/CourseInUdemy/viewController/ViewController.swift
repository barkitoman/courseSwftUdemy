//
//  ViewController.swift
//  CourseInUdemy
//
//  Created by Julian Barco on 9/5/19.
//  Copyright © 2019 Julian Barco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnConstrain: NSLayoutConstraint!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var txtDiscount: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func screen(){
        if UIDevice().userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.height{
                case 1136:
                    print("IPhone 5 o Iphone SE")
                case 1334:
                    print("Iphone 6 6S 7 8")
                case 1792:
                    print("Iphone XR")
                self.btnConstrain.constant = 300
                case 2208:
                    print("Iphone Plus")
                case 2436:
                    print("Iphone 10 XS")
                case 2688:
                    print("Iphone XS MAX")
                default:
                    print("Cualquier otro tamaño \(UIScreen.main.nativeBounds.height)")
            }
        }
    }
    
    @objc func keyBoard(notification: Notification){
        guard let keyBoardUP = (notification.userInfo! [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height == 1136 {
                self.view.frame.origin.y = -keyBoardUP.height
            }
        }else{
            self.view.frame.origin.y = 0
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func btnCalculate(_ sender: Any) {
        if txtQuantity.text != "" && txtDiscount.text != "" {
            self.view.endEditing(true)
            guard let discount  = txtDiscount.text else { return }
            guard let quantity = txtQuantity.text else { return }
            let numDiscount = (discount as NSString).floatValue
            let numQuantity = (quantity as NSString).floatValue
            let totalDiscount = numQuantity * numDiscount / 100
            let total = numQuantity - totalDiscount
            self.result.text = "$\(total)"
            self.lbDiscount.text = "$\(totalDiscount)"
        }else{
            let alert = UIAlertController(title: "Alert", message: "We need quantity and discount", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    @IBAction func btnClear(_ sender: Any) {
        self.view.endEditing(true);
        self.result.text = "$0.00"
        self.lbDiscount.text = "$0.00"
        self.txtQuantity.text = ""
        self.txtDiscount.text = ""
    }
    
}

