import SwiftUI

struct HomeScreen: View {
    let container: AppContainer
    @State private var model: HomeScreenModel

    init(container: AppContainer) {
        self.container = container
        _model = State(initialValue: HomeScreenModel(
            catalogStore: container.catalogStore,
            savedBillersStore: container.savedBillersStore,
            dueBillsStore: container.dueBillsStore,
            dateStream: container.dateStream
        ))
    }

    var body: some View {
        List {
            RemindersSection(data: model.remindersData, language: container.settingsStore.language)
            SavedBillersSection(data: model.savedBillersData)
            CategoriesSection(data: model.categoriesData)
        }
        .navigationTitle(L10n.string("app_title"))
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink(value: Route.search) {
                    Label(L10n.string("search_billers"), systemImage: "magnifyingglass")
                }
                NavigationLink(value: Route.history) {
                    Label(L10n.string("payment_history"), systemImage: "clock.arrow.circlepath")
                }
                NavigationLink(value: Route.settings) {
                    Label(L10n.string("settings"), systemImage: "gearshape")
                }
            }
        }
        .task { await model.consumeDates() }
    }
}

private struct RemindersSection: View {
    let data: HomeRemindersData
    let language: String

    var body: some View {
        switch data {
        case .loading:
            Section(L10n.string("upcoming_bills")) { ProgressView() }
        case let .loaded(items):
            if !items.isEmpty {
                Section(L10n.string("upcoming_bills")) {
                    ForEach(items) { item in
                        ReminderRow(item: item, language: language)
                    }
                }
            }
        }
    }
}

private struct SavedBillersSection: View {
    let data: HomeSavedBillersData

    var body: some View {
        switch data {
        case .loading:
            Section(L10n.string("saved_billers")) { ProgressView() }
        case let .loaded(items):
            if !items.isEmpty {
                Section(L10n.string("saved_billers")) {
                    ForEach(items) { item in
                        SavedBillerRow(item: item)
                    }
                }
            }
        }
    }
}

private struct CategoriesSection: View {
    let data: HomeCategoriesData

    private static let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        Section(L10n.string("pay_a_bill")) {
            switch data {
            case .loading:
                ProgressView()
            case .error:
                Text(L10n.string("something_went_wrong"))
            case let .loaded(items):
                LazyVGrid(columns: Self.columns, spacing: 8) {
                    ForEach(items) { item in
                        CategoryCard(item: item)
                    }
                }
            }
        }
    }
}

private struct ReminderRow: View {
    let item: DueBillItemData
    let language: String

    var body: some View {
        NavigationLink(value: Route.billFetch(billerId: item.billerId)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.billerName)
                    Text(dueLabel(item.dueInDays)).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Text(formatPaise(item.amountPaise, language: language))
            }
        }
    }
}

private struct SavedBillerRow: View {
    let item: SavedBillerItemData

    var body: some View {
        NavigationLink(value: Route.billFetch(billerId: item.billerId)) {
            VStack(alignment: .leading) {
                Text(item.nickname)
                Text(item.billerName).font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }
}

private struct CategoryCard: View {
    let item: CategoryItemData

    @Environment(Router.self) private var router

    var body: some View {
        Button {
            router.push(.category(categoryId: item.id))
        } label: {
            VStack(spacing: 4) {
                Image(systemName: categoryIcon(item.id))
                    .font(.system(size: 28))
                Text(item.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(12)
        }
        .buttonStyle(.plain)
    }
}

private func dueLabel(_ dueInDays: Int) -> String {
    if dueInDays == 0 { return L10n.string("due_today") }
    if dueInDays > 0 {
        return String.localizedStringWithFormat(L10n.string("due_in_days"), dueInDays)
    }
    return String.localizedStringWithFormat(L10n.string("overdue_by_days"), -dueInDays)
}
