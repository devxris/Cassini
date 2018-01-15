//
//  DemoURLs.swift
//  Cassini
//
//  Created by Chris Huang on 06/12/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

struct DemoURLs {
	
	static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
	// static let stanford = URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/55/Stanford_Oval_September_2013_panorama.jpg")
	
	static var NASA: [String: URL] = {
		let NASAURLStrings = [
			"Cassini": "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
			"Earth"  : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
			"Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
		]
		var urls = [String: URL]()
		for (key, value) in NASAURLStrings {
			urls[key] = URL(string: value)
		}
		return urls
	}()
}
