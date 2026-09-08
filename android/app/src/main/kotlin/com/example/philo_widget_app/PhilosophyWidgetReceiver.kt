package com.example.philo_widget_app

import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import android.appwidget.AppWidgetManager
import es.antonborri.home_widget.HomeWidgetProvider

class PhilosophyWidgetReceiver : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            // Pull the quote data sent from Flutter, with fallback defaults
            val quoteText = widgetData.getString("quote_text", "Man is condemned to be free.")
            val quoteAuthor = widgetData.getString("quote_author", "Jean-Paul Sartre")

            // Bind the data to your layout text views
            val views = RemoteViews(context.packageName, R.layout.philosophy_widget_layout).apply {
                setTextViewText(R.id.widget_quote, "\"$quoteText\"")
                setTextViewText(R.id.widget_author, "- $quoteAuthor")
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}