//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Chris Huang on 15/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
	
	// MARK: UISplitViewControllerDelegate
	
	override func awakeFromNib() {
		super.awakeFromNib()
		splitViewController?.delegate = self
	}
	
	func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		if let imageViewController = secondaryViewController as? ImageViewController {
			if imageViewController.imageURL == nil {
				return false
			}
		}
		return true
	}

	// MARK: Navigations
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			if let url = DemoURLs.NASA[identifier] {
				if let imageVC = segue.destination.contents as? ImageViewController {
					imageVC.imageURL = url
					imageVC.title = (sender as? UIButton)?.currentTitle
				}
			}
		}
	}
}

extension UIViewController {
	var contents: UIViewController {
		if let navCon = self as? UINavigationController {
			return navCon.visibleViewController ?? navCon
		}
		return self
	}
}
