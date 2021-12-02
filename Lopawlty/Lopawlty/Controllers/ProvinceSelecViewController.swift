//
//  ProvinceSelecViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

import UIKit
import CoreData
import Firebase

class ProvinceSelecViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var BtnSelectProv: UIButton!
    
    var provinces: [Province] = []
 
    var selectedProvince : String = ""
    
    var loggedInCustomer : Customer = Customer()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        BtnSelectProv.layer.cornerRadius = 15
        
        provinces = [Province(name: "Alberta"),Province(name: "British Columbia"), Province(name: "Manitoba"), Province(name: "New Brunswick"), Province(name: "Newfoundland and Labrador"),Province(name: "Nova Scotia"),Province(name: "Ontario"),Province(name: "Prince Edward Island"), Province(name: "Quebec"), Province(name: "Saskatchewan")]
        
        //setLoggedInCustomer()
        
        //print("logged in customer is \(loggedInCustomer.name)")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provinces.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return provinces[row].name
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedProvince = provinces[row].name
    }
    
    func updateProvince(provinceString : String) {
        do {
        
        guard let customerId = UserDefaults.standard.string(forKey: "LoggedInCustomerId") else {
            return
        }
            let db = Firestore.firestore()
            db.collection("Customers").document(customerId).setData( ["province" : provinceString], merge: true){ err in
                if let err = err {
                    print("error adding customer: \(err)")
                } else {
                    print("updated province of user")
                    self.performSegue(withIdentifier: "ProvinceSelectToProducts", sender: nil)
                }
            }        } catch {
            print("Error while updating user")
        }
        
    }
 

    @IBAction func selectButtonClicked(_ sender: Any) {
        updateProvince(provinceString: selectedProvince)
    }
    
   

}
