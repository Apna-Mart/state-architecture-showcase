package com.billpayments.features.home.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.History
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.pluralStringResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.core.format.formatPaise

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreen(
    viewModel: HomeViewModel,
    language: String,
    onSearch: () -> Unit,
    onHistory: () -> Unit,
    onSettings: () -> Unit,
    onCategory: (String) -> Unit,
    onBiller: (String) -> Unit,
) {
    val reminders by viewModel.reminders.collectAsStateWithLifecycle()
    val savedBillers by viewModel.savedBillers.collectAsStateWithLifecycle()
    val categories by viewModel.categories.collectAsStateWithLifecycle()
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.app_title)) },
                actions = {
                    IconButton(onClick = onSearch) { Icon(Icons.Filled.Search, stringResource(R.string.search_billers)) }
                    IconButton(onClick = onHistory) { Icon(Icons.Filled.History, stringResource(R.string.payment_history)) }
                    IconButton(onClick = onSettings) { Icon(Icons.Filled.Settings, stringResource(R.string.settings)) }
                },
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
            remindersSection(reminders, language, onBiller)
            savedBillersSection(savedBillers, onBiller)
            categoriesSection(categories, onCategory)
        }
    }
}

private fun LazyListScope.remindersSection(data: HomeRemindersData, language: String, onBiller: (String) -> Unit) {
    when (data) {
        HomeRemindersData.Loading -> item(key = "reminders-loading") {
            SectionLoading(stringResource(R.string.upcoming_bills))
        }
        is HomeRemindersData.Loaded -> if (data.items.isNotEmpty()) {
            item(key = "reminders-header") { SectionTitle(stringResource(R.string.upcoming_bills)) }
            items(data.items, key = { "reminder:${it.billerId}:${it.account}" }) { item ->
                ReminderRow(item, language, onBiller)
            }
        }
    }
}

private fun LazyListScope.savedBillersSection(data: HomeSavedBillersData, onBiller: (String) -> Unit) {
    when (data) {
        HomeSavedBillersData.Loading -> item(key = "saved-loading") {
            SectionLoading(stringResource(R.string.saved_billers))
        }
        is HomeSavedBillersData.Loaded -> if (data.items.isNotEmpty()) {
            item(key = "saved-header") { SectionTitle(stringResource(R.string.saved_billers)) }
            items(data.items, key = { "saved:${it.billerId}:${it.account}" }) { item ->
                SavedBillerRow(item, onBiller)
            }
        }
    }
}

private fun LazyListScope.categoriesSection(data: HomeCategoriesData, onCategory: (String) -> Unit) {
    item(key = "categories") { CategoriesSection(data, onCategory) }
}

@Composable
private fun ReminderRow(item: DueBillItemData, language: String, onBiller: (String) -> Unit) {
    Card(modifier = Modifier.fillMaxWidth().clickable { onBiller(item.billerId) }) {
        ListItem(
            headlineContent = { Text(item.billerName) },
            supportingContent = { Text(dueLabel(item.dueInDays)) },
            trailingContent = { Text(formatPaise(item.amountPaise, language)) },
        )
    }
}

@Composable
private fun SavedBillerRow(item: SavedBillerItemData, onBiller: (String) -> Unit) {
    Card(modifier = Modifier.fillMaxWidth().clickable { onBiller(item.billerId) }) {
        ListItem(
            headlineContent = { Text(item.nickname) },
            supportingContent = { Text(item.billerName) },
        )
    }
}

@Composable
private fun dueLabel(dueInDays: Int): String = when {
    dueInDays == 0 -> stringResource(R.string.due_today)
    dueInDays > 0 -> pluralStringResource(R.plurals.due_in_days, dueInDays, dueInDays)
    else -> pluralStringResource(R.plurals.overdue_by_days, -dueInDays, -dueInDays)
}

@Composable
private fun CategoriesSection(data: HomeCategoriesData, onCategory: (String) -> Unit) {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        SectionTitle(stringResource(R.string.pay_a_bill))
        when (data) {
            HomeCategoriesData.Loading -> CircularProgressIndicator()
            is HomeCategoriesData.Error -> Text(stringResource(R.string.something_went_wrong))
            is HomeCategoriesData.Loaded -> LazyVerticalGrid(
                columns = GridCells.Fixed(3),
                modifier = Modifier.fillMaxWidth().height(((data.items.size + 2) / 3 * 96).dp),
                verticalArrangement = Arrangement.spacedBy(8.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                userScrollEnabled = false,
            ) {
                items(data.items, key = { it.id }) { item ->
                    CategoryCard(item, onCategory)
                }
            }
        }
    }
}

@Composable
private fun CategoryCard(item: CategoryItemData, onCategory: (String) -> Unit) {
    Card(modifier = Modifier.clickable { onCategory(item.id) }) {
        Column(
            modifier = Modifier.fillMaxWidth().padding(12.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(4.dp),
        ) {
            Icon(categoryIcon(item.id), item.name, modifier = Modifier.size(28.dp))
            Text(item.name, style = MaterialTheme.typography.labelMedium, maxLines = 2)
        }
    }
}

@Composable
private fun SectionTitle(title: String) {
    Text(
        title,
        style = MaterialTheme.typography.titleLarge,
        modifier = Modifier.padding(top = 8.dp),
    )
}

@Composable
private fun SectionLoading(title: String) {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        SectionTitle(title)
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
            CircularProgressIndicator(modifier = Modifier.padding(8.dp))
        }
    }
}
