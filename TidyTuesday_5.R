

food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')
Agg_emmision <-aggregate(co2_emmission~country, food_consumption,sum)

require(ggplot2)
require(ggthemes)
require(tidyverse)

# Retrievethe map data
World <- map_data("world")
# Compute the centroid as the mean longitude and lattitude
# Used as label coordinate for country's names
world_data <- World %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat))

world_data <-world_data %>% 
  rename(
    country = region
  )

CountryToMap<-merge(world_data,Agg_emmision,by="country")

# World map
worldmap <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map()

map <- worldmap +
  geom_point(aes(x = long, y = lat,
                 size = co2_emmission),
             data = CountryToMap, alpha = .5) +
  scale_size_continuous(range = c(1, 8), breaks = c(250, 500, 750, 1000)) +
  ggtitle("Total Carbon Emmission per Country")

map
