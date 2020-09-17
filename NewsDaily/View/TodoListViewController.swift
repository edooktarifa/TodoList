//
//  TodoListViewController.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!

    var presenter: TodoListPresenterProtocol?
    
    var todos : [Daily] = []
    
    
    var updateData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    @IBAction func saveData(sender: UIButton){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.delegate = self
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            self.presenter?.removeTodo(self.todos[indexPath.row])
        }
        
        let updateToDo = UITableViewRowAction(style: .normal, title: "Update") { (action, indexPath) in
            let alert = UIAlertController(title: "Update Data", message: "Please input something", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Update", style: .default) { (alertAction) in
                let textField = alert.textFields![0] as UITextField
                
                self.presenter?.updateTodo(self.todos[indexPath.row], title: textField.text ?? "")
            }
            
            alert.addTextField { (textField) in
                textField.placeholder = "update detail"
            }
            
            alert.addAction(action)
            self.present(alert, animated:true)
            
            
        }
        return [deleteAction, updateToDo]
        }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension TodoListViewController: TodoListViewProtocol, addTodo{
    func addData(add: String) {
        self.updateData = add
        presenter?.addTodo(updateData ?? "")
    }
    
    
    func showTodos(_ todos: [Daily]) {
        self.todos = todos
        tblView.reloadData()
    }
    
    func showErrorMessage(_ message: String) {
        
    }
    
}
