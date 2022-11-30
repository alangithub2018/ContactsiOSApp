//
//  Contact.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import Foundation

struct Contact: Decodable {
    var id: String
    var first_name: String
    var middle_name: String
    var surname: String
    var last_name: String
    var email: String
    var rfc: String
    var age: Int
    var dob: String
    var profile_image: String
    var phone_number: String
    var gender: String
    var academic_degree: String
}
