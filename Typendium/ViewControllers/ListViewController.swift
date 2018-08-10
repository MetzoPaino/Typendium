//
//  ListViewController.swift
//  Typendium
//
//  Created by William Robinson on 07/08/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ListCollectionViewControllerProtocol {
    
    func cellSelected() {
        print("o")
      //  navigationController?.performSegue(withIdentifier: "ShowVC", sender: self)
        self.performSegue(withIdentifier: "ShowVC", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedVC" {
            let viewController = segue.destination as! ListCollectionViewController
            viewController.delegate = self
        }
        

    }

}
