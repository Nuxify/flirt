package com.nuxify.flirt

import android.app.Notification
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import android.util.Log
import java.net.HttpURLConnection
import java.net.URL
import com.example.live_activities.LiveActivityManager

class CustomLiveActivityManager(context: Context) :
    LiveActivityManager(context) {
    companion object {
        private const val TAG = "CustomLiveActivityManager"
    }
    private val context: Context = context.applicationContext
    private val pendingIntent = PendingIntent.getActivity(
        context, 200, Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
        }, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

    private val remoteViews = RemoteViews(
        context.packageName, R.layout.live_activity
    )

    // This function is not necessary
    // This function will load an image from a URL and resize it to 64dp
    suspend fun loadImageBitmap(imageUrl: String?): Bitmap? {
        // Convert 64dp to pixels based on device density
        val dp = context.resources.displayMetrics.density.toInt()

        return withContext(Dispatchers.IO) {
            if (imageUrl.isNullOrEmpty()) return@withContext null
            try {
                val url = URL(imageUrl)
                val connection = url.openConnection() as HttpURLConnection
                connection.doInput = true
                connection.connectTimeout = 3000
                connection.readTimeout = 3000
                connection.connect()
                connection.inputStream.use { inputStream ->
                    // Decode the bitmap from the input stream and resize it
                    val originalBitmap = BitmapFactory.decodeStream(inputStream)
                    originalBitmap?.let {
                        val targetSize = 64 * dp
                        val aspectRatio =
                            it.width.toFloat() / it.height.toFloat()
                        val (targetWidth, targetHeight) = if (aspectRatio > 1) {
                            targetSize to (targetSize / aspectRatio).toInt()
                        } else {
                            (targetSize * aspectRatio).toInt() to targetSize
                        }
                        Bitmap.createScaledBitmap(
                            it,
                            targetWidth,
                            targetHeight,
                            true
                        )
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
                null
            }
        }
    }

    // Update the RemoteViews with book data
    private suspend fun updateRemoteViews(
        bookTitle: String,
        author: String,
        page: Int,
        coverUrl: String?,
    ) {
        remoteViews.setTextViewText(R.id.book_title, bookTitle)
        remoteViews.setTextViewText(R.id.book_author, author)
        remoteViews.setTextViewText(R.id.page_number, "Page $page")

        val coverBitmap = if (!coverUrl.isNullOrEmpty()) loadImageBitmap(coverUrl) else null
        coverBitmap?.let { image ->
            remoteViews.setImageViewBitmap(R.id.book_cover, image)
        }
    }


    // This function will be called by the plugin to build the notification
    // [notification] is the Notification.Builder instance used by the plugin
    // [event] is the event type ("create" or "update")
    // [data] is the data passed to the plugin
    override suspend fun buildNotification(
        notification: Notification.Builder,
        event: String,
        data: Map<String, Any>
    ): Notification {
        Log.d(TAG, "buildNotification event=$event data=$data")
        // Parse book-specific fields
        val bookTitle = data["bookTitle"] as? String ?: (data["title"] as? String ?: "Untitled")
        val author = data["author"] as? String ?: "Unknown"
        val page = when (val p = data["page"]) {
            is Number -> p.toInt()
            is String -> p.toIntOrNull() ?: 1
            else -> 1
        }

        val coverUrl = if (event == "update") null else data["coverUrl"] as? String

        try {
            updateRemoteViews(bookTitle, author, page, coverUrl)
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return notification
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .setContentTitle("$bookTitle by $author")
            .setContentIntent(pendingIntent)
            .setContentText("Page $page")
            .setStyle(Notification.DecoratedCustomViewStyle())
            .setCustomContentView(remoteViews) // Collapsed view
            .setCustomBigContentView(remoteViews) // Expanded view
            .setPriority(Notification.PRIORITY_LOW)
            .setCategory(Notification.CATEGORY_EVENT)
            .setVisibility(Notification.VISIBILITY_PUBLIC)
            .build()
    }
}