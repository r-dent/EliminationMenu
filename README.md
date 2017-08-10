# EliminationMenu
[![CocoaPods](https://img.shields.io/cocoapods/v/EliminationMenu.svg)](http://cocoadocs.org/docsets/EliminationMenu)
[![Platform](https://img.shields.io/cocoapods/p/EliminationMenu.svg)](http://cocoadocs.org/docsets/EliminationMenu)
[![CocoaPods](https://img.shields.io/cocoapods/l/EliminationMenu.svg)](LICENSE)
[![Travis](https://img.shields.io/travis/r-dent/EliminationMenu.svg)](https://travis-ci.org/r-dent/EliminationMenu)

Some kind of menu that eliminates all values which were not selected.

<p align="center" >
![Screenshot](/Resources/EliminationMenu.gif?raw=true "Screenshot")
<p>

## Installation

Just drag the Folder `Sources` into your project.

Or if you´re using CocoaPods, add this to your Podfile: 

	pod EliminationMenu
	
## Usage

You can create an EliminationMenu view in Interface Builder or in code.
            
### Create entries
    
To set up the entries, create an array of instances conforming to `EliminationMenuItem` and set it to the `items` property of the menu object.

```swift
let menuEntries = [
    EliminationMenu.Item(value: "SomeValue", title: "First"),
    EliminationMenu.Item(value: "SomeOtherValue", title: "Second"),
    EliminationMenu.Item(value: UIImage(named: "filename"), title: "Third"), // You can use values of any kind.
    EliminationMenu.Item(value: "...or a view", title: "Fourth"),
    "Just a String"
]
menu.items = menuEntries
```

*Hint*: The default type `EliminationMenu.Item` can be used to populate the menu. But you can also make your own types conform to `EliminationMenuItem` and use them directly.
`String` already conforms to it. So you can use Strings as menu items.
    
### Create Menu

Use the convenience method to create a menu and add it as a subview to your view controllers view.

```swift
let menu = EliminationMenu.createMenu(withItems: menuEntries, inView: view, aligned: .topRight, margin: CGPoint(x: 0, y: 20)) { (item) in
	print("Selected value: \(item.value)")
}
```

If you want to use Interface Builder, just add a `UIView` and pin 2 of its edges (vertical and horizontal). Set `EliminationMenu` as the views class. Also add a width and a height constraint to supress warnings. Enable "_Remove at build time_" on the size constraints. The menu will get an intrinsic size at runtime.

You can also create an instance of `EliminationMenu` and constrain it yourself in a superview. Be shure to call `menu.setup()` after all.

See the [example code](EliminationMenu/ViewController.swift) for a better insight.
    
### Customize

You can customize the properties of your menu like this:

```swift
menu.font = UIFont.boldSystemFont(ofSize: 24)
menu.color = UIColor.white

menu.setup()
```
    
Be shure to call `menu.setup()` to apply your changes. See the [documentation](http://cocoadocs.org/docsets/EliminationMenu) for more ways to customize.

## License

`EliminationMenu` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.