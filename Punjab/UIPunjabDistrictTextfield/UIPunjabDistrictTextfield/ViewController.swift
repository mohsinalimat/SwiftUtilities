//
//  ViewController.swift
//  UIPunjabDistrictTextfield
//
//  Created by vijay vir on 8/18/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	  @IBOutlet weak var txtDistrict: PunjabDistrictPickerTextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		txtDistrict.closureDidSelectDistrict = {
			district in

			print(district)
		}
		txtDistrict.closureEditingDidBegin = {  district in
			print("closureEditingDidBegin")
		}
		txtDistrict.closureEditingDidEnd = { district in
			print("closureEditingDidEnd")

		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
