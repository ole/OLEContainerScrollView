# OLEContainerScrollView

A `UIScrollView` subclass that intelligently handles multiple child scroll views and does not interfere with UIKitʼs cell reuse functionality.

Written by Ole Begemann, May 2014.

## Blog Post

Please read my [blog post about OLEContainerScrollView](http://oleb.net/blog/2014/05/scrollviews-inside-scrollviews/) for details about the implementation.

## Demo App

To check out the demo app:

1. Clone this repository.
2. Run `pod install` inside the repository's directory to install the dependencies via [CocoaPods](http://cocoapods.org).

The demo app uses a class I have written named `SimulatedTableView` to illustrate how a `UITableView` reuses its cells. This class uses [Facebook's Pop library](https://github.com/facebook/pop) for animations.

## License

Published under the MIT License. See the `LICENSE` file for details.
