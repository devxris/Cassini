//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Chris Huang on 15/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

	// MARK: Navigations
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			if let url = DemoURLs.NASA[identifier] {
				if let imageVC = segue.destination as? ImageViewController {
					imageVC.imageURL = url
					imageVC.title = (sender as? UIButton)?.currentTitle
				}
			}
		}
	}
}
