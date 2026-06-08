struct FetchedBill: Equatable {
    let billerId: String
    let account: String
    let customerName: String
    let amountPaise: Int64
    let dueDate: CalendarDate
    let billNumber: String
}
