import Foundation

enum PaymentStatus: String, Codable {
    case processing = "Processing"
    case success = "Success"
    case failed = "Failed"
}

struct Payment: Equatable {
    let id: String
    let billerId: String
    let billerName: String
    let categoryId: String
    let account: String
    let amountPaise: Int64
    let paidAtUtc: Date
    let status: PaymentStatus
}

struct Payments: Equatable {
    let items: [Payment]
    let nextId: Int

    func byId(_ id: String) -> Payment? {
        items.first { $0.id == id }
    }

    func hasProcessing(billerId: String, account: String) -> Bool {
        items.contains {
            $0.billerId == billerId && $0.account == account && $0.status == .processing
        }
    }

    func adding(_ payment: Payment) -> Payments {
        Payments(items: items + [payment], nextId: nextId + 1)
    }

    func updatingStatus(id: String, status: PaymentStatus) -> Payments {
        Payments(
            items: items.map { $0.id == id ? Payment(
                id: $0.id,
                billerId: $0.billerId,
                billerName: $0.billerName,
                categoryId: $0.categoryId,
                account: $0.account,
                amountPaise: $0.amountPaise,
                paidAtUtc: $0.paidAtUtc,
                status: status
            ) : $0 },
            nextId: nextId
        )
    }

    static let empty = Payments(items: [], nextId: 1)
}
