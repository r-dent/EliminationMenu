# EliminationMenu

Some kind of menu that eliminates all values which were not selected.

## Installation

Just drag the EliminationMenu.swift into your project.

Or if you´re using CocoaPods, add this to your Podfile: 

	pod EliminationMenu
	
## Usage

You can create an EliminationMenu view in Interface Builder or in code.

### Create Menu

In Interface Builder, just add a `UIView` and pin it´s bottom edge and one of its sides. Set EliminationMenu as the views class. Also add a width and a height constraint to supress warnings. Enable "_Remove at build time_" on the size constraints. The view will get an intrinsic size.

In code, just create an `EliminationMenu` object, add it as subview and attach the constraints in code like this:

	// Create the Menu.
	let menu = EliminationMenu()
	
	// Set its align to whatever side you will pin it to.
	menu.align = .Right
	
	// Prevent autolayout from creating constraints.
	menu.translatesAutoresizingMaskIntoConstraints = false
	
	// Add menu to your view.
    view.addSubview(menu)
    
    // Add constraints to the view.
    view.addConstraints([
        NSLayoutConstraint(item: view, attribute: .RightMargin, relatedBy: .Equal, toItem: menu, attribute: .Right, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: view, attribute: .BottomMargin, relatedBy: .Equal, toItem: menu, attribute: .Bottom, multiplier: 1, constant: 20)
    ])
            
### Add entries
    
To set up the entries, create an array of `EliminationMenu.Item`s and set it to the `items` property of the menu object.

    menu.items = [
        EliminationMenu.Item(value: "SomeValue", title: "First"),
        EliminationMenu.Item(value: "SomeOtherValue", title: "Second"),
        EliminationMenu.Item(value: UIImage(named: "filename"), title: "Third"), // You can use values of any kind.
        EliminationMenu.Item(value: "...or a view", title: "Fourth")
    ]
