//
//  SecondViewController.swift
//  Update
//
//  Created by R on 10/05/1443 AH.
//  Copyright © 1443 R. All rights reserved.
//

import UIKit
protocol addNewItem {
    func addItem(title:String)
    func updateItem(title:Item,titlle2:String)
}

class SecondViewController: UIViewController {
    
    var delegate:addNewItem?
    var updatedText:Item?

    
    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tf.text = updatedText?.title
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let newTitle = tf!.text{
            if (updatedText?.id) != nil{
                delegate?.updateItem(title: updatedText!, titlle2: newTitle)
                navigationController?.popViewController(animated: true)
            }else{
                    delegate?.addItem(title:newTitle)
                    navigationController?.popViewController(animated: true)
            }
        }
    }
}
