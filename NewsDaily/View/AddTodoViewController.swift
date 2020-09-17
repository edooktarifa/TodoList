//
//  AddTodoViewController.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit

protocol addTodo {
    func addData(add: String)
}

class AddTodoViewController: UIViewController {

    @IBOutlet weak var addDataTf: UITextField!
    
    var delegate: addTodo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addDataBtn(){
        delegate.addData(add: addDataTf.text ?? "")
        closePopUp()
    
    }
    
    func closePopUp(){
        self.removeFromParent()
        self.view.removeFromSuperview()
    }

}
