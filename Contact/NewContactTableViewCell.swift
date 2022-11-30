//
//  NewContactTableViewCell.swift
//  Contact
//
//  Created by MacBookAir on 27/11/22.
//

import UIKit

class NewContactTableViewCell: UITableViewCell {
    
    @IBOutlet var first_name: UITextField!
    @IBOutlet var middle_name: UITextField!
    @IBOutlet var surname: UITextField!
    @IBOutlet var last_name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var rfc: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var dob: UITextField!
    @IBOutlet var genero: UISwitch!
    @IBOutlet var phone_number: UITextField!
    @IBOutlet var academic_degree: UITextField!
    @IBOutlet var profile_image: UITextField!
    @IBOutlet var generoLabel: UILabel!
    
    @IBAction func onGenderChanged(_ sender: Any) {
        if genero.isOn {
            generoLabel.text = "Hombre"
        } else {
            generoLabel.text = "Mujer"
        }
    }
    
    @IBAction func onGuardarContacto(_ sender: Any) {
        let alert = UIAlertController(title: "Agregar Contacto!", message: "Contacto creado exitosamente", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
            self.parentViewController?.navigationController?.popToRootViewController(animated: true)
        }))
        
        // Make post request with values
        let bodyParameters: [String : Any] = [
            "first_name": first_name.text! as String,
            "middle_name": middle_name.text! as String,
            "surname": surname.text! as String,
            "last_name": last_name.text! as String,
            "email": email.text! as String,
            "rfc": rfc.text! as String,
            "age": Int(age.text!)! as Int,
            "dob": dob.text! as String,
            "profile_image": profile_image.text! as String,
            "phone_number": phone_number.text! as String,
            "gender": genero.isOn ? "male" : "female",
            "academic_degree": academic_degree.text! as String
        ]
        
        Networking.makeHTTPRequest(
            completion: {_ in
                
            },
            endpoint: "/contact",
            parameters: bodyParameters,
            method: "POST",
            headers: [
                "accept": "text/plain",
                "Content-Type": "application/json"
            ]
        )
        
        self.parentViewController?.navigationController?
            .present(alert, animated: true, completion: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController?
            }
        }
        return nil
    }
}
