//
//  TodoListPresenter.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    
    func addTodo(_ todo: String) {
        interactor?.saveTodo(todo)
    }
    
    func viewWillAppear() {
        interactor?.retrieveTodos()
    }
    
    func removeTodo(_ todo: Daily) {
        interactor?.deleteTodo(todo)
    }
    
    func updateTodo(_ update: Daily, title: String) {
        interactor?.updateToDo(update, title: title)
    }
    
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    func didUpdateTodo(_ todo: Daily) {
        interactor?.retrieveTodos()
    }
    
    
    func didAddTodo(_ todo: Daily) {
        interactor?.retrieveTodos()
    }
    
    func didRetrieveTodos(_ todos: [Daily]) {
        view?.showTodos(todos)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
    func didRemoveTodo(_ todo: Daily) {
        interactor?.retrieveTodos()
    }
}
