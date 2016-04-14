//
//  ViewController.swift
//  RGEliminationMenu
//
//  Created by Roman Gille on 14.04.16.
//  Copyright © 2016 Roman Gille. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eliminationMenu: RGEliminationMenu!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eliminationMenu.items = [
            MenuItem(title: "First", value: "SomeValue"),
            MenuItem(title: "Second", value: "SomeOtherValue"),
            MenuItem(title: "Third", value: "This could also be an Image"),
            MenuItem(title: "Fourth", value: "...or a view")
        ]
        eliminationMenu.align = .Right
        
        eliminationMenu.selectionHandler = {item in
            let menuItem = item as! MenuItem
            
            let alert = UIAlertController(
                title: "Value selected",
                message: "Selected item \"\(menuItem.title)\" with value \"\(menuItem.value)\"",
                preferredStyle: .Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

