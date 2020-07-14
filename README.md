# RedditClient

## Objective

A simple Reddit client that shows the top entries from Reddit, thumbnails can be opened full screen and post can be tapped to be displayed on a detail screen.

It was implemented following this guidelines:

- Assume the latest platform and use Swift
- Use UITableView / UICollectionView to arrange the data.
- Please refrain from using any dependency manager [cocoapods / carthage / etc], instead, use URLSession 
- Support all Device Orientation
- Support all Devices screen (iPhone/iPad)
- Use Storyboards

## Shows

The application shows the following information for each post:

- Title (at its full length, so take this into account when sizing your cells)
- Author
- entry date, following a format like “x hours ago” 
- A thumbnail for those who have a picture.
- Number of comments
- Unread status

The thumbnail should be able to be tapped and opened full screen.

## Includes

The application includes the following functionality and features:

- Pull to Refresh
- Pagination support
- Saving pictures in the picture gallery
- App state-preservation/restoration
- Indicator of unread/read post (updated status, after post it’s selected)
- Dismiss Post Button (remove the cell from list. Animations required)
- Dismiss All Button (remove all posts. Animations required)

## Time Spent

It was completed in 4 hours.

