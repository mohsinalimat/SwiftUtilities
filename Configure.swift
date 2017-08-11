//
//  Configure.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation
import UIKit

let base: String = "http://182.75.35.84:83/902-2/rest/"

let baseURL: String = base + "index.php"

// let baseURL: String = "http://localhost:8182/"

let notificationLogout = Notification.Name("notificationLogout")

enum ServerDefaults {

    case userProfilePicUrl

    case type

    case isPhoneVerified

    case profileImages

    case bannerImage

    case deviceType

    var name: String {
        switch self {
        case .userProfilePicUrl: return base + "user-default.png"

        case .type : return Social.general.rawValue

        case .isPhoneVerified : return "0"

        case .profileImages : return base + "profile_image/"

        case .bannerImage : return "http://182.75.35.84:83/902/uploads/banner.jpg"

        case .deviceType : return "2"

        }
    }

}

enum Validations: Int {
    case maxPassword = 15

    case minPassword = 6

    case maxUsername = 25

    case maxPhoneNumber = 10

    case maxOpt = 8

    var length: Int {
        switch self {
        case .maxPassword: return 15

        case .minPassword : return 6

        case .maxUsername: return 15

        case .maxPhoneNumber : return 10

        case .maxOpt : return 6
        }
    }

}

enum Status: Int {

    case success = 1

    case unableToRegisterPhone = 201

    case failure = 0

    case deadlock = 777

}

enum Technlogy: String {
    case ios
}

enum ServiceMethod: String {
    case login

    case signUp

    case logout

    case sendOTP = "sendMeOTP"

    case phoneVerification

    case forgotPassword

    case changePassword

    case profileGetInfo = "getProfileInfo"

    case profileUpdateInfo = "updateProfileInfo"

    case deliveryAddressAdd

    case deliveryAddressInfo

    case deliveryAddressUpdate

    case isDeliveryAddressExist

    case saveUpdateDeliveryAddress

    /************** Projects Api ***************/

    case allBanners

    case addPrescription = "addPrescriptionOrder"

    case allPrescriptionOrders

    case singlePrescriptionOrder

    case singlePrescriptionOrderInvoice

    case prescriptionCancel

    //case  successPayments

}

enum SocialMediaType {
    case facebook

    case google

    case general

    var name: String {
        switch self {

        case .facebook: return "facebook"

        case .google : return "google"

        case .general: return "general"

        }
    }

}
enum Social: String {
    case facebook

    case gooogle = "google"

    case general

}

enum OrderStatus: String {
    case submitted = "Submitted"

    case opened = "Opened"

    case invoiced = "Invoiced"

    case canceled = "Cancel"

    case delivered = "Delivered"

    var name: String {
        switch self {
        case .submitted: return "Submitted"

        case .opened : return "Opened"

        case .invoiced: return "Invoiced"

        case .canceled : return "Cancel"

        case .delivered : return "Delivered"
        }
    }

}

// TODO: Client Side Webservices

struct UserSession: StructJSONSerializable {

    /*
     
     ProfileImage = "";
     authToken = fd00a3f5721a9f7a86cd4b4459567ec2;
     "created_at" = "0000-00-00 00:00:00";
     deviceToken = "<null>";
     deviceType = 2;
     email = "";
     firstName = "<null>";
     id = 24;
     isPhoneVerified = 1;
     lastName = "<null>";
     oldpassword = "";
     otp = 554553;
     password = "$2y$10$ZvskNZUKDWuKOd98Kw7GqO5iItoeK1yOS.MDx9KczA5UUNb7GDC7S";
     regPhoneNumber = 1564645645;
     socialMediaToken = 0;
     socialMediaType = "";
     socialMediaUserId = 0;
     "updated_at" = "0000-00-00 00:00:00";
     userStatus = 0;
     userType = Member;
     username = "<null>";
     */

    var userId: String

    var token: String

    var authToken: String

    var isPhoneVerified: Bool = false

    var type: String = SocialMediaType.general.name

    init(userId: String, token: String, isPhoneVerified: Bool, type: String) {

        self.userId = userId

        self.token = token

        self.authToken = token

        self.isPhoneVerified = isPhoneVerified

        self.type = type

    }

    init(body: Dictionary<String, Any>) {

        userId = body["regPhoneNumber"] as? String ?? body["userId"] as! String

        token = body["authToken"] as? String ?? body["token"] as! String

        authToken = body["authToken"] as? String ?? body["token"] as! String

        isPhoneVerified = body["isPhoneVerify"] as? Bool ?? body["isPhoneVerified"] as? Bool ?? false

        type = body["socialMediaType"] as? String ?? body["type"] as! String

    }

}

struct SignUpSocialOutGoing: StructJSONSerializable {

    var method: String = ServiceMethod.signUp.rawValue

    var deviceType: String = ServerDefaults.deviceType.name

    var socialMediaUserId: String

    var socialMediaToken: String

    var regPhoneNumber: String = ""

    var socialMediaType: String

    var deviceToken: String

    init(regPhoneNumber: String, app: SocialMediaType, deviceToken: String, socialMediaUserId: String, socialMediaToken: String) {
        self.regPhoneNumber = regPhoneNumber

        self.socialMediaType = app.name

        self.socialMediaUserId = socialMediaUserId

        self.socialMediaToken = socialMediaToken

        self.deviceToken = deviceToken

    }

}

struct SignUpOutGoing: StructJSONSerializable {

    var method: String = ServiceMethod.signUp.rawValue

    var regPhoneNumber: String = ""

    var deviceType: String = ServerDefaults.deviceType.name

    var socialMediaType: String

    init(regPhoneNumber: String, app: SocialMediaType) {

        self.regPhoneNumber = regPhoneNumber

        self.socialMediaType = app.name

    }

}

struct PhoneVerificationOutGoing: StructJSONSerializable {

    var method: String = ServiceMethod.phoneVerification.rawValue

    var authToken: String!

    var isPhoneVerified: Int!

    init(authToken: String, isPhoneVerified: Int? = 1) {
        self.authToken = authToken

        self.isPhoneVerified = isPhoneVerified
    }

}

struct SignUpInComming: StructJSONSerializable {

    var authToken: String!
    var deviceType: String!
    var isPhoneVerified: Int!
    var otp: Int!
    var regPhoneNumber: String!
    var socialMediaType: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */

    init(body: Dictionary<String, Any>) {
        authToken = body["authToken"] as? String

        deviceType = body["deviceType"] as? String

        isPhoneVerified = body["isPhoneVerified"] as? Int

        otp = body["otp"] as? Int

        regPhoneNumber = body["regPhoneNumber"] as? String

        socialMediaType = body["socialMediaType"] as? String
    }

}

/*
 
 {
 body =     {
 authToken = ae44262f15f370adc8fc67ae9a7dd3e0;
 deviceType = 2;
 isPhoneVerified = 0;
 otp = 20239;
 regPhoneNumber = 4444444444;
 socialMediaType = 0;
 };
 createdAt = 1486016404;
 message = "User created";
 status = 1;
 }
 
 */

struct UserLoginResponse: StructJSONSerializable {
    var userId: String

    var token: String

    var isPhoneVerified = false

    var type: String = Social.general.rawValue

}
// MARK: Profile

struct ProfileInfoOutGoing: StructJSONSerializable {

    var authToken: String

    var method: String = ServiceMethod.profileGetInfo.rawValue

    init(authToken: String) {

        self.authToken = authToken

    }

}
struct ProfileUpdateOutgoing: StructJSONSerializable {

    var authToken: String

    var firstName: String

    var lastName: String

    var profileImage: String

    var method: String = ServiceMethod.profileUpdateInfo.rawValue

    init(authToken: String, firstName: String, lastName: String, profileImage: String) {

        self.authToken = authToken

        self.firstName = firstName

        self.lastName = lastName

        self.profileImage = profileImage

    }

}

struct ProfileDetailsInComming: StructJSONSerializable {
    var userId: String

    var firstName: String

    var lastName: String

    var profileImage: String

    var isPhoneVerified: String

    var regPhoneNumber: String

    var type: String

    var response: Dictionary<String, Any> = [:]

    init(body: Dictionary<String, Any>) {

        userId = body["userId"] as! String? ?? ""

        firstName = body["firstName"] as! String? ?? ""

        lastName = body["lastName"] as! String? ?? ""

        profileImage = body["profileImage"] as! String? ?? ServerDefaults.userProfilePicUrl.name

        isPhoneVerified = body["isPhoneVerified"] as! String? ?? ServerDefaults.isPhoneVerified.name

        regPhoneNumber = body["regPhoneNumber"] as! String? ?? ""

        type = body["type"] as! String? ?? ServerDefaults.type.name

        response = body

    }

}

// TODO: Server Side Webservices

struct UserSocial: StructJSONSerializable {
    var userId: String

    var token: String

    var type: String

    var method: String

}

struct UserSignUp: StructJSONSerializable {
    var firstName: String

    var lastName: String

    var userId: String

    var password: String

    var type: String

    var method: String

}

struct ForgotPassword: StructJSONSerializable {
    var phoneNumber: String

    var method: String
}

struct loginOutGoing: StructJSONSerializable {

    var regPhoneNumber: String

    var password: String

    var socialMediaType: String

    var method: String = ServiceMethod.login.rawValue

    var deviceToken: String

    init(regPhoneNumber: String, password: String, deviceToken: String, socialMediaType: String) {
        self.deviceToken = deviceToken

        self.regPhoneNumber = regPhoneNumber

        self.password = password

        self.socialMediaType = socialMediaType

    }
}

struct UserLogIn: StructJSONSerializable {
    var userId: String

    var password: String

    var type: String

    var method: String

}

struct SendMeOTP: StructJSONSerializable {
    var token: String

    var userId: String

    var regPhoneNumber: String

    var method: String = ServiceMethod.sendOTP.rawValue
}

struct LogoutOutGoing: StructJSONSerializable {
    var authToken: String

    var method: String = ServiceMethod.logout.rawValue

    init(authToken: String) {

        self.authToken = authToken
    }

}

// struct Logout: StructJSONSerializable
// {
//    var token: String
//
//    var method: String = ServiceMethod.sendOTP.rawValue
//
//    var userId: String
// }

struct PhoneVerification: StructJSONSerializable {
    var token: String

    var userId: String

    var otp: String

    var method: String = ServiceMethod.phoneVerification.rawValue
}

// MARK: Dilvery Address

struct DeliveryAddress: StructJSONSerializable {
    var name: String

    var pincode: String

    var address: String

    var landmark: String

    var city: String

    var state: String

    var phoneNumber: String

    var addressId: String

    init(resonse: Dictionary<String, Any>) {
        self.name = resonse["name"]! as! String

        self.pincode = resonse["pincode"]! as! String

        self.address = resonse["address"]! as! String

        self.landmark = resonse["landmark"]! as! String

        self.city = resonse["city"]! as! String

        self.state = resonse["state"]! as! String

        self.phoneNumber = resonse["phoneNumber"]! as! String

        self.addressId = resonse["id"] as! String? ?? resonse["addressId"] as! String? ?? ""
    }

    init(addressId: String, name: String, pincode: String, address: String, landmark: String, city: String, state: String, phoneNumber: String) {
        self.name = name

        self.pincode = pincode

        self.address = address

        self.landmark = landmark

        self.city = city

        self.state = state

        self.phoneNumber = phoneNumber

        self.addressId = addressId

    }

}

struct SaveUpdateDeliveryAddressInComming: StructJSONSerializable {
    var name: String

    var pincode: String

    var address: String

    var landmark: String

    var city: String

    var state: String

    var phoneNumber: String

    var addressId: String

    init(resonse: Dictionary<String, Any>) {
        self.name = resonse["name"]! as! String

        self.pincode = resonse["pincode"]! as! String

        self.address = resonse["address"]! as! String

        self.landmark = resonse["landmark"]! as! String

        self.city = resonse["city"]! as! String

        self.state = resonse["state"]! as! String

        self.phoneNumber = resonse["phoneNumber"]! as! String

        self.addressId = resonse["id"] as! String? ?? resonse["addressId"] as! String? ?? ""
    }

}

struct SaveUpdateDeliveryAddressOutGoing: StructJSONSerializable {
    //  saveUpdateDeliveryAddress
    var userId: String

    var token: String

    var method: String = ServiceMethod.saveUpdateDeliveryAddress.rawValue

    var isAddresFound: String = "No"

    var addressId: String

    var name: String = ""

    var pincode: String

    var address: String

    var landmark: String

    var city: String

    var state: String

    var phoneNumber: String

    init(userId: String,
         token: String,
         method: String,
         isAddresFound: String,
         addressId: String,
         name: String,
         pincode: String,
         address: String,
         landmark: String,
         city: String,
         state: String,
         phoneNumber: String) {

        self.userId = userId

        self.token = token

        self.method = method

        self.isAddresFound = isAddresFound

        self.name = name

        self.pincode = pincode

        self.address = address

        self.landmark = landmark

        self.city = city

        self.state = state

        self.phoneNumber = phoneNumber

        self.addressId = addressId

    }

}

struct DeliveryAddressOutGoing: StructJSONSerializable {

    var userId: String

    var token: String

    var method: String = ServiceMethod.deliveryAddressAdd.rawValue

    var address: DeliveryAddress

}

struct IsDeliveryAddressExistOutGoing: StructJSONSerializable {

    var token: String

    var method: String = ServiceMethod.isDeliveryAddressExist.rawValue

    var userId: String

}

struct ChangePasswordOutGoing: StructJSONSerializable {
    var method: String = ServiceMethod.changePassword.rawValue

    var userId: String

    var token: String

    var type: String

    var newPassword: String

    var oldPassword: String

    init(method: String, userId: String, token: String, type: String, newPassword: String, oldPassword: String) {

        self.method = method

        self.userId = userId

        self.token = token

        self.type = type

        self.newPassword = newPassword

        self.oldPassword = oldPassword

    }

}

// MARK: BannersApis

struct AllBannersOutGoing: StructJSONSerializable {
    var method: String = ServiceMethod.allBanners.rawValue

}

struct AllBannersIncomming: StructJSONSerializable {

    struct BannerList: StructJSONSerializable {

        var bannerImage: String = ""

        init(bannerImage: Dictionary<String, Any>) {

            self.bannerImage = bannerImage["bannerImage"] as! String? ?? ServerDefaults.bannerImage.name

        }

    }

    var bannerList: [BannerList] = []

    init(body: Dictionary<String, Any>) {
        if let bannerListG = body["bannerList"] as? [Any] {
            for object in bannerListG {

                let order = BannerList(bannerImage: object as! Dictionary<String, Any>)
                bannerList.append(order)

            }

        }

    }

}

struct DeliveryAddressInfoOutGoing: StructJSONSerializable {
    var userId: String

    var token: String

    var method: String = ServiceMethod.deliveryAddressInfo.rawValue

    init(method: String, userId: String, token: String) {

        self.method = method

        self.userId = userId

        self.token = token
    }

}

// MARK: Prescription APIS

// ******************************************************************************

struct AllPrescriptionOrdersIncomming: StructJSONSerializable {
    struct PrescriptionOrder: StructJSONSerializable {
        var id: String = ""

        var createdAt: String = ""

        var imageName: String = ""

        var orderStatus: String = OrderStatus.submitted.name

        var orderImage: String = ""

        var prescriptionOrdersID: String = ""

        var title: String = ""

        var userId: String = ""

        init(order: Dictionary<String, Any>) {

            self.id = order["orderList"] as! String? ?? ""

            self.createdAt = order["createdAt"] as! String? ?? ""

            self.imageName = order["imageName"] as! String? ?? ""

            self.orderStatus = order["orderStatus"] as! String? ?? OrderStatus.submitted.name

            self.orderImage = order["orderImage"] as! String? ?? ""

            self.prescriptionOrdersID = order["prescriptionordersID"] as! String? ?? ""

            self.title = order["title"] as! String? ?? ""

            self.userId = order["userId"] as! String? ?? ""

        }

    }

    var prescriptionOrders: [PrescriptionOrder] = []

    init(body: Dictionary<String, Any>) {
        if let orderList = body["orderList"] as? [Any] {
            for object in orderList {

                let order = PrescriptionOrder(order: object as! Dictionary<String, Any>)
                prescriptionOrders.append(order)

            }

        }

    }

}

struct AllPrescriptionOrdersOutGoing: StructJSONSerializable {
    var method: String = ServiceMethod.prescriptionCancel.rawValue

    var userId: String

    var token: String

}

struct SinglePrescriptionOrderOutgoing: StructJSONSerializable {
    var method: String = ServiceMethod.singlePrescriptionOrder.rawValue

    var userId: String

    var token: String

    var orderId: String

    var orderStatus: String

}

// MARK: Invoice

struct SinglePrescriptionOrderInComming: StructJSONSerializable {

    struct OrderImage: StructJSONSerializable {
        var orderImage: String = ""

        init(images: Dictionary<String, Any>) {

            self.orderImage = images["orderImage"] as! String? ?? ""

        }
    }
    var imageList: [OrderImage] = []

    var orderStatus: String = OrderStatus.submitted.name

    var title: String = ""

    var orderId: String = ""

    init(body: Dictionary<String, Any>) {

        self.orderId = body["orderId"] as! String? ?? ""

        self.title = body["title"] as! String? ?? ""

        self.orderStatus = body["orderStatus"] as! String? ?? OrderStatus.submitted.name

        if let orderList = body["imageList"] as? [Any] {
            for object in orderList {

                let order = OrderImage(images: object as! Dictionary<String, Any>)

                imageList.append(order)

            }

        }

    }

}

struct SinglePrescriptionOrderInvoiceOutGoing: StructJSONSerializable {
    var method: String = ServiceMethod.singlePrescriptionOrderInvoice.rawValue

    var userId: String

    var token: String

    var orderId: String

    var orderStatus: String

}

struct SinglePrescriptionOrderInvoiceInComming: StructJSONSerializable {

    struct InvoiceList: StructJSONSerializable {
        var grossTotal: String = ""
        var invoiceAddedOn: String = ""
        var invoiceCreatedBy: String = ""
        var invoice_id: String = ""
        var itemName: String = ""
        var orderImagesId: String = ""
        var orderStatus: String = ""

        var paidDateTime: String = ""
        var paymentStatus: String = ""
        var perItemPrice: String = ""

        var quanity: String = ""
        var title: String = ""
        var transcationId: String = ""

        init(images: Dictionary<String, Any>) {

            self.grossTotal = images["grossTotal"] as! String? ?? ""

            self.invoiceAddedOn = images["invoiceAddedOn"] as! String? ?? ""

            self.invoiceCreatedBy = images["invoiceCreatedBy"] as! String? ?? ""

            self.invoice_id = images["invoice_id"] as! String? ?? ""

            self.itemName = images["itemName"] as! String? ?? ""

            self.orderImagesId = images["orderImagesId"] as! String? ?? ""

            self.orderStatus = images["orderStatus"] as! String? ?? ""

            self.paidDateTime = ""

            self.paymentStatus = ""

            self.perItemPrice = images["perItemPrice"] as! String? ?? ""

            self.quanity = images["quanity"] as! String? ?? ""

            self.title = images["title"] as! String? ?? ""

            self.transcationId = images["transcationId"] as! String? ?? ""

        }
    }

    struct Address: StructJSONSerializable {
        var address = ""
        var city = ""
        var id = ""
        var landmark = ""
        var name = ""
        var phoneNumber = ""
        var pincode = ""
        var state = ""
        var updateAt = ""
        var userId = ""

        init(addressBody: Dictionary<String, Any>) {
            address = addressBody["address"] as! String? ?? ""
            city = addressBody["city"] as! String? ?? ""
            id = addressBody["id"] as! String? ?? ""
            landmark = addressBody["landmark"] as! String? ?? ""
            name = addressBody["name"] as! String? ?? ""
            phoneNumber = addressBody["phoneNumber"] as! String? ?? ""
            pincode = addressBody["pincode"] as! String? ?? ""
            state = addressBody["state"] as! String? ?? ""
            updateAt = addressBody["updateAt"] as! String? ?? ""
            userId = addressBody["userId"] as! String? ?? ""
        }

    }
    var invoiceList: [InvoiceList] = []

    var orderStatus: String = OrderStatus.submitted.name

    var title: String = ""

    var orderId: String = ""

    var total: String = ""

    var isAddresFound: Bool = false

    var address: Address?

    init(body: Dictionary<String, Any>) {

        self.total = body["total"] as! String? ?? "9999"

        self.orderId = body["orderId"] as! String? ?? ""

        self.title = body["title"] as! String? ?? ""

        self.orderStatus = body["orderStatus"] as! String? ?? OrderStatus.submitted.name

        if body["isAddresFound"] as! String! == "Yes" {
            isAddresFound = true

            address = Address(addressBody: body["address"] as! Dictionary<String, Any>)

        } else {
            isAddresFound = false
        }
        if let orderList = body["invoiceList"] as? [Any] {
            for object in orderList {

                let order = InvoiceList(images: object as! Dictionary<String, Any>)

                invoiceList.append(order)

            }

        }

    }

}

struct AddPrescriptionOutGoing: StructJSONSerializable {

    var userId: String

    var token: String

    var method: String = ServiceMethod.addPrescription.rawValue //  //addPrescription

    var title: String

    // Files are added Sepratedlly

}

// MARK: Invoice

struct Profile: StructJSONSerializable {
    var userId: String

    var firstName: String

    var lastName: String

    var profileUrl: String

}

struct Medicine: StructJSONSerializable {

    var medicineId: String

    var medicineName: String

    var quantity: String

    var mrp: String

    var price: String //

    var total: String // price*quantity

    var url: String

    init(medicine: Dictionary<String, Any>) {
        medicineId = medicine["medicineId"]! as! String

        medicineName = medicine["medicineName"]! as! String

        quantity = medicine["quantity"]! as! String

        mrp = medicine["mrp"]! as! String

        price = medicine["medicineId"]! as! String

        total = medicine["total"]! as! String

        url = medicine["url"]! as! String

    }

}
struct Invoice: StructJSONSerializable {

    var price: String

    var discount: String

    var total: String

    init(invoice: Dictionary<String, Any>) {
        price = invoice["price"]! as! String

        discount = invoice["discount"]! as! String

        total = invoice["total"]! as! String

    }

}

struct PrescriptionList: StructJSONSerializable {
    var method: String = ServiceMethod.prescriptionCancel.rawValue

    var userId: String

    var token: String

}

struct PrescriptionInvoice: StructJSONSerializable {
    var orderId: String

    var medicines: [Medicine]?

    var invoice: Invoice?

    init(prescriptionInvoice: Dictionary<String, Any>) {
        orderId = prescriptionInvoice["orderId"]! as! String

        if prescriptionInvoice["invoice"] != nil {

            invoice = Invoice(invoice: prescriptionInvoice["invoice"]! as! Dictionary<String, Any>)

        }

        if prescriptionInvoice["medicines"] != nil {

            let jsonMedicine = prescriptionInvoice["medicines"] as! [Any]

            medicines = []

            if jsonMedicine.count > 0 {
                for medicine in jsonMedicine {
                    if let medicineO = Medicine(medicine: medicine as! Dictionary) as Medicine? {

                        print("medicineO ", medicineO)

                        medicines?.append(medicineO)
                    }

                }

            } else {
                medicines = []
            }

        } else {
            medicines = []
        }

        print("confirm meddice", medicines ?? "not have vak")

    }

}
