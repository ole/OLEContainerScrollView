# OLEContainerScrollView

A `UIScrollView` subclass that intelligently handles multiple child scroll views and does not interfere with UIKitʼs cell reuse functionality.

Written by Ole Begemann, May 2014.

## ⚠️ No maintenance ⚠️

**This project is not being maintained. I’m not using it myself and I don’t want to spend time on it adding more features. I still think the code contains some good ideas. Feel free to read the code and take ideas from it and/or maintain your own fork.**

## Blog Post

Please read my [blog post about OLEContainerScrollView](http://oleb.net/blog/2014/05/scrollviews-inside-scrollviews/) for details about the implementation.

## Demo App

To check out the demo app:

1. Clone this repository.
2. Open `OLEContainerScrollViewDemo.xcodeproj` in Xcode.

The demo app uses a class I have written named `OLESimulatedTableView` to illustrate how a `UITableView` reuses its cells.

## Usage

1. Manually clone this repository to your machine or add it as a Git submodule to your project.
2. Drag the folder `OLEContainerScrollView` into your Xcode project to add all the files in it to your project.
3. `#import "OLEContainerScrollView.h"`
4. Create an `OLEContainerScrollView` instead of a regular `UIScrollView`.
5. Add subviews (like table views, collection views, regular scroll views, or just other regular views) to the scroll view’s `contentView`. Check out the comments in `OLEContainerScrollView.h`.

## License

Published under the MIT License. See the `LICENSE` file for details.
