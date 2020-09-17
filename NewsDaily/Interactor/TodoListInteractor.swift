//
//  TodoListInteractor.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class TodoListInteractor: TodoListInteractorInputProtocol {
    
    weak var presenter: TodoListInteractorOutputProtocol?
    var todoStore = CoreDataManager.sharedManager
    var todos: [Daily] {
        return todoStore.fetchAllPersons() ?? []
    }
    
    
    func retrieveTodos() {
        presenter?.didRetrieveTodos(todos)
    }
    
    func saveTodo(_ todo: String) {
        let addTodo = todoStore.insertPerson(name: todo)
        presenter?.didAddTodo(addTodo!)
    }
    
    func deleteTodo(_ todo: Daily) {
        todoStore.delete(person: todo)
        retrieveTodos()
    }
    
    func updateToDo(_ update: Daily, title: String) {
        todoStore.update(name: title, person: update)
        retrieveTodos()
    }
    
}
