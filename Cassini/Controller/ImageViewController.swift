//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chris Huang on 15/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
	
	// MARK: Model
	
	var imageURL: URL? {
		didSet {
			imageView.image = nil
			// only fetch image while on screen, if not, fetch in viewDidAppear
			if view.window != nil { fetchImage() }
		}
	}
	
	// MARK: ViewController Life Cycle
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if imageView.image == nil { fetchImage() }
	}
	
	/* get url from Bundle.main.url()
	override func viewDidLoad() { // for demo only
		super.viewDidLoad()
		if imageURL == nil { imageURL = DemoURLs.stanford }
	} */
	
	// MARK: Properties
	
	var imageView = UIImageView()
	
	private var image: UIImage? { // a computed property to access image rather than imageView.image
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
			// must hook up with scrollView's contentSize, which is nil before outlet is set
			scrollView?.contentSize = imageView.frame.size
			spinner?.stopAnimating() // stop spinner right after image is set
		}
	}

	// MARK: Storyboard
	
	/* Embedded imageView to scrollView in storyboard
		1. scrollView will inset 20 points for each side automatically
		2. constrain to scrollView's contentSize
		3. change imageView intrinsic size to placeholder
	*/
	
	/* Embedded imageView to scrollView in code */
	
	@IBOutlet weak var scrollView: UIScrollView! {
		didSet {
			// 2 mandates to pinch scroll view: min/maxZoomScale and viewForZooming delegate method
			scrollView.minimumZoomScale = 1/25
			scrollView.maximumZoomScale = 1.0
			scrollView.delegate = self
			scrollView.addSubview(imageView)
		}
	}
	
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	// MARK: UIScrollViewDelegate
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? { return imageView }
	
	// MARK: Private funcs
	
	private func fetchImage() {
		if let url = imageURL { // get data through network or file
			spinner.startAnimating()
			// weak self here not to prevent memory cycle but prevent network is too time-consuming
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				let urlContents = try? Data(contentsOf: url) // better to use do-catch block, also blocks the main queue
				DispatchQueue.main.async {
					if let imageData = urlContents, url == self?.imageURL { // ensure loading url is demanding url
						self?.image = UIImage(data: imageData)
					}
				}
			}
		}
	}
}
