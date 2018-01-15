//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chris Huang on 15/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
	
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
	
	// for demo only
	override func viewDidLoad() {
		super.viewDidLoad()
		if imageURL == nil { imageURL = DemoURLs.stanford }
	}

	// MARK: Storyboard
	
	@IBOutlet weak var imageView: UIImageView!
	
	// MARK: Private funcs
	
	private func fetchImage() {
		if let url = imageURL { // get data through network or file
			let urlContents = try? Data(contentsOf: url)
			if let imageData = urlContents {
				imageView.image = UIImage(data: imageData)
			}
		}
	}
}
