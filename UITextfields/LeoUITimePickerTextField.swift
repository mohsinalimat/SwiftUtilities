//
//  LeoUITimePickerTextField.swift
//  IPadDemo
//
//  Created by vijay vir on 8/15/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class LeoUITimePickerTextField: UITextField {

	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/
	
	// MARK: Outlets
	
	// MARK: Variables
	
	var timePicker: UIDatePicker = UIDatePicker()
	
	@IBInspectable var timePickerToPass: String = "yyyy-MM-dd"
	
	@IBInspectable var timeformatToShow: String = "dd-MM-yyyy"
	
	// MARK: CLC
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		timePicker.datePickerMode = .time
		
		self.inputView = timePicker
		
		
		
		self.addTarget(self , action: #selector(LeoUITimePickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControlEvents.editingDidBegin)
		
		self.addTarget(self , action: #selector(LeoUITimePickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControlEvents.editingDidEnd)
		//        datePicker.datePickerMode = UIDatePickerModeDate;
		//
		//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		//        //[dateFormatter setDateFormat:dateformatVJ];
		//
		//
		//        //  datePicker.date = [NSDate date];
		//        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
		//
		//        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
		//        datePicker.tag = 6;
		//        self.inputView = datePicker;
		//
		
	}
	
	// MARK: Actions
	
	// MARK: Functions
	
	
	
}
extension LeoUITimePickerTextField  {
	
}

// MARK: Functions editingDidBegin editingDidEnd

extension LeoUITimePickerTextField {
	
	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField)
	{
		
		self.text = "\( timePicker.date)"
	}
	
	func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField)
	{
		
		self.text = "\( timePicker.date)"
		
		
	}
	
	func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField)
	{
		self.text = "\( timePicker.date)"
	}
	
}
