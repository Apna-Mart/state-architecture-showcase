import SwiftUI

struct BillerListItem: View {
    let data: BillerListItemData

    var body: some View {
        NavigationLink(value: Route.billFetch(billerId: data.id)) {
            VStack(alignment: .leading) {
                Text(data.name)
                Text(data.categoryName).font(.subheadline).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
