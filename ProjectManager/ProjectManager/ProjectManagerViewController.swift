//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SwiftUI
import UIKit


class ProjectManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Project Manager"
        
        let rightBarButton = UIBarButtonItem.init(title: "+", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
