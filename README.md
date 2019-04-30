[![codebeat badge](https://codebeat.co/badges/76f19096-e991-44e1-a742-0ede8a74673e)](https://codebeat.co/projects/github-com-prate-k-keepup-develop)


[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5c47ad387a414993bf85f58d0bbab7e6)](https://www.codacy.com/app/Prate-k/KeepUp?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Prate-k/KeepUp&amp;utm_campaign=Badge_Grade)


[![codecov](https://codecov.io/gh/Prate-k/KeepUp/branch/develop/graph/badge.svg)](https://codecov.io/gh/Prate-k/KeepUp)


[![Build Status](https://app.bitrise.io/app/a9f7e32cc21cd5ad/status.svg?token=23-yARCRzJLw1Ul5_lzLxg)](https://app.bitrise.io/app/a9f7e32cc21cd5ad)


[![Build status](https://build.appcenter.ms/v0.1/apps/91978e84-d2a2-45e4-a54d-44d93161f07e/branches/develop/badge)](https://appcenter.ms)


# KeepUp
An iOS Application to favourite your artists and follow their releases and lyrics.

This application allows users to “KeepUp”-to-date with the latest music releases from their favourite artists -  as well as read the lyrics, save the lyrics or print the lyrics.

The user can hide the songs from the artists which they are not interested in and therefore have quick access to the lyrics of their favourite songs instantly.

The users can also view simple information  about the  artists and also get notified if and when the artists have new music released, whenever the application is started.

The application also attempts to suggest popular artists and other suggesstions based on the user’s favourites list

## Features

- [x] Top Artists and Popular Songs
The application uses Deezer API to retrieve the latest top 10 charts of artist and also shows the most popular song by each of those artists. This updates every time the application is transitioned to the home screen

<img src = "./Screenshots/Empty Search Screen Portrait.png"  width = "300"  height = "550">   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

- [x] Favourite Artists
This feature allows the user to search for and favourite artists they would like to follow and keep up to date with their latest releases etc... The feature is based on the search feature, where the user will be giveb the option to favourite the artist via a favourites button which updates accordingly.

- [x] Search Feature
This feature makes use of the Deezer API to allow the user to search for any artist and view more details on it.

- [x] View albums
This feature loads all the albums of the artists in reverse chronological order (latest first) and allows the user to view more information about the artist (orgin/birth place, members, genres) while being able to add/remove them from their personal favourites list. The user is also able to click on a specific album to view all the tracks within the album.

- [x] View Songs
Similar to the view albums, the user can click on the songs and read the lyrics of that specific song (The lyrics were obtained used the MusixMatch API)

- [x] Settings
This feature allows the user to view more details on the application and details on the services used etc...

## Requirements

- iOS 11.0+
- Xcode 10.2+
