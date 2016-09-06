# AutoLayoutProtocol
The AutoLayoutProtocol helps you to build views using Auto Layout without the pain of rewriting the same boiler plate code again and again.

## Installation

### Manually

Just copy **AutoLayoutProtocol.swift** into your Xcode Project.

## Usage

### Example
Let your view inherit from the AutoLayoutProtocol. You have to initialize the properties **views** and **alConstraints** and the functions **configureView()** and **configureConstraints()** to conform to the protocol.

You add all the views within the **configureView()** function using **addALSubview(view: UIView)** or **addALSubview(view: UIView, toView: UIView)**. I for myself add all the code concerning the views into **configureView()**.

You add constraints by using **appendConstraints(withVisualFormat: String)** or you append constraints to alConstraints.

```swift
final class ExampleView: UIView, AutolayoutProtocol {
    internal var views: [String : UIView] = [:]
    internal var alConstraints: [NSLayoutConstraint] = []
    
    private let viewToAdd = UIView()
    private let secondViewToAdd = UIView()
    
    init() {
      super.init(frame: .zero)
      configureView()
      configureConstraints()
    }
    
    internal func configureView() {
      addALSubview(view: viewToAdd)
      addALSubview(view: secondViewToAdd, toView: viewToAdd)
    }
    
    internal func configureConstraints() {
      appendConstraints(withVisualFormat: "V:|[viewToAdd]|")
      appendConstraints(withVisualFormat: "H:|[viewToAdd]|")
  
      appendConstraints(withVisualFormat: "V:[secondViewToAdd(100)]")
      appendConstraints(withVisualFormat: "H:[secondViewToAdd(100)]")
  
      alConstraints.append(NSLayoutConstraint(item: secondViewToAdd, attribute: .centerX, relatedBy: .equal, toItem: secondViewToAdd.superview, attribute: .centerX, multiplier: 1, constant: 0))
      alConstraints.append(NSLayoutConstraint(item: secondViewToAdd, attribute: .centerY, relatedBy: .equal, toItem: secondViewToAdd.superview, attribute: .centerY, multiplier: 1, constant: 0))
      
      NSLayoutConstraint.activate(alConstraints)
    }
}
```
