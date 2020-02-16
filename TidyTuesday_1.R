
### Tidy Tuesdays - 21.01.2020
library(tidyverse)

## Load data
spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')
## Omit Na values
spotify_songs<-na.omit(spotify_songs)

## Average variables per category
genre_average <- spotify_songs %>%
  group_by(playlist_genre) %>%
  summarise(Popularity = mean(track_popularity),
            Danceability = mean(danceability),
            Energy = mean(energy),
            Instrumentalness = mean(instrumentalness),
            Acousticness = mean(acousticness),
            Valence = mean(valence))

## Rename the Genres
Genre_Renamed<-genre_average %>% mutate(playlist_genre=recode(playlist_genre, `edm`="EDM",
                                                              `latin`="Latin",`pop`="Pop",`r&b`="R&B",`rap`="Rap",`rock`="Rock"))

## Spider/radar plots
devtools::install_github("ricardo-bion/ggradar", 
                         dependencies = TRUE)
library(ggradar)
library(scales)

Genre_Scaled<-Genre_Renamed %>% 
  mutate_each(funs(rescale), -playlist_genre)

ggradar(Genre_Scaled, base.size = 12, font.radar = "ariel",
        values.radar = c("0%", "50%", "100%"),legend.title = "Music Genres",
        plot.title = "Music Properties on Spotify", legend.text.size = 14, legend.position = "left")
