//
//  UserView.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/04/10.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit

struct UserInfo {
    var name: String
    var fileName: String
}

class UserView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
