//
//  SkyFloatingLabelDatePickerTextField.swift
//  MedicalApp
//
//  Created by Apple on 22/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit

class LeoUIDatePickerTextField: UITextField
{

    // MARK: Outlets
    
    // MARK: Variables
	
    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBInspectable var datePickerToPass: String = "yyyy-MM-dd"
    
    @IBInspectable var dateformatToShow: String = "dd-MM-yyyy"
    
    // MARK: CLC
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        datePicker.datePickerMode = .date
        
        self.inputView = datePicker
			
			
			
			self.addTarget(self , action: #selector(LeoUIDatePickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControlEvents.editingDidBegin)
			
			self.addTarget(self , action: #selector(LeoUIDatePickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControlEvents.editingDidEnd)
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
extension LeoUIDatePickerTextField  {
	
}

	// MARK: Functions editingDidBegin editingDidEnd

extension LeoUIDatePickerTextField {
	
	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField)
	{
		
		
		self.text = "\( datePicker.date)"
	}
	
	func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField)
	{
		
				self.text = "\( datePicker.date)"
		
		
	}
	
	func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField)
	{
				self.text = "\( datePicker.date)"
	}
	
}
