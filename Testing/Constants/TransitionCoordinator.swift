//
//  TransitionCoordinator.swift
//  Testing
//
//  Created by user187615 on 12/4/20.
//
import UIKit

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return nil
    }

}

