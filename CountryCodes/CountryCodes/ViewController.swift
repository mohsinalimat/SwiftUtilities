//
//  ViewController.swift
//  CountryCodes
//
//  Created by vijay vir on 8/11/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtCountryCode: CountryPickerTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		txtCountryCode.closureDidSelectCountry = { country in
			
			print(country)
			
		}
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

