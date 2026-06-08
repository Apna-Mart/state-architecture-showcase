func categoryIcon(_ categoryId: String) -> String {
    switch categoryId {
    case "electricity": "bolt.fill"
    case "water": "drop.fill"
    case "piped-gas": "flame.fill"
    case "lpg": "fuelpump.fill"
    case "mobile-postpaid": "iphone"
    case "mobile-prepaid": "simcard.fill"
    case "dth": "dot.radiowaves.up.forward"
    case "broadband": "wifi"
    case "landline": "phone.fill"
    case "fastag": "road.lanes"
    case "credit-card": "creditcard.fill"
    case "insurance": "cross.case.fill"
    case "loan-emi": "building.columns.fill"
    case "education": "graduationcap.fill"
    case "municipal-tax": "building.2.fill"
    default: "doc.text.fill"
    }
}
