//
//  NewsDailyProtocol.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

protocol TodoListViewProtocol: class {
    
    var presenter: TodoListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showTodos(_ todos: [Daily])
    func showErrorMessage(_ message: String)
}

protocol TodoListPresenterProtocol: class {
    
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewWillAppear()
    func addTodo(_ todo: String)
    func removeTodo(_ todo: Daily)
    func updateTodo(_ update: Daily, title: String)
}

protocol TodoListInteractorInputProtocol: class {
    
    var presenter: TodoListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveTodos()
    func saveTodo(_ todo: String)
    func deleteTodo(_ todo: Daily)
    func updateToDo(_ update: Daily, title: String)
}

protocol TodoListInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didAddTodo(_ todo: Daily)
    func didRemoveTodo(_ todo: Daily)
    func didRetrieveTodos(_ todos: [Daily])
    func didUpdateTodo(_ todo: Daily)
    func onError(message: String)
}

protocol TodoListRouterProtocol: class {
    
    static func createTodoListModule() -> UIViewController
    
    // PRESENTER -> ROUTER
}
