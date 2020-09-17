//
//  Router.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit


class TodoListRouter: TodoListRouterProtocol {
    
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createTodoListModule() -> UIViewController {
        let navController = storyboard.instantiateViewController(withIdentifier: "TodoListNavigation") as! UINavigationController
        guard let todoListViewController = navController.topViewController as? TodoListViewController else { fatalError("Invalid View Controller") }
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router = TodoListRouter()
        
        todoListViewController.presenter = presenter
        presenter.view = todoListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
}
}
