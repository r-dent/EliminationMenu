//
//  ViewController.swift
//  EliminationMenu
//
//  Created by Roman Gille on 14.04.16.
//  Copyright © 2016 Roman Gille. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eliminationMenu: EliminationMenu!
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the menu created in interface builder.
        
        eliminationMenu.font = UIFont.boldSystemFontOfSize(24)
        eliminationMenu.color = UIColor.whiteColor()
        
        eliminationMenu.selectionHandler = {item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\"\n\nThe value is:\n\"\(item.value)\""
        }
        
        eliminationMenu.items = [
            EliminationMenu.Item(value: "SomeValue", title: "First"),
            EliminationMenu.Item(value: "SomeOtherValue", title: "Second"),
            EliminationMenu.Item(value: "This could also be an Image", title: "Third"),
            EliminationMenu.Item(value: "...or a view", title: "Fourth")
        ]
        
        // Create nemu in code.
        
        let rightMenu = EliminationMenu()
        
        rightMenu.selectionHandler = {item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\"\n\nThe value is:\n\"\(item.value)\""
        }
        
        rightMenu.items = [
            EliminationMenu.Item(value: "Layer over layer.", icon: UIImage(named: "fabric")),
            EliminationMenu.Item(value: "There was this browser...", icon: UIImage(named: "safari")),
            EliminationMenu.Item(value: "Save to disk.", icon: UIImage(named: "disk")),
            EliminationMenu.Item(value: "Mic check. One, two...", icon: UIImage(named: "check")),
            EliminationMenu.Item(value: "To the heart!", icon: UIImage(named: "heart"))
        ]
        
        rightMenu.align = .Right
        
        // Add menu to layout.
        
        rightMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightMenu)
        
        view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .RightMargin, relatedBy: .Equal, toItem: rightMenu, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .BottomMargin, relatedBy: .Equal, toItem: rightMenu, attribute: .Bottom, multiplier: 1, constant: 20)
            ])
        
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

