
## Read the data

measles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-25/measles.csv')

mmr_Type_Year<-subset(measles, year!='null' & type != 'NA', select=c(year,type,mmr))
mmr_Type_Year_agg <- aggregate(mmr ~ type + year, data=mmr_Type_Year ,mean)

library(ggplot2)
library(harrypotter)
mmr_plot <- ggplot(mmr_Type_Year_agg, aes(x=year, y= mmr, fill= type, group=type)) + 
  geom_bar(position="dodge", stat="identity") + 
  scale_fill_hp_d(option = "LunaLovegood") +
  labs(subtitle="Rate of mmr vaccines per type of school", 
       y="Rate of mmr vaccines given", 
       x="Year", 
       title="TidyTuesday 25.02.20202",
       caption="")

plot(mmr_plot)


xmed_Type_Year<-subset(measles, year!='null' & type != 'NA', select=c(year,type,xmed))
xmed_Type_Year_agg <- aggregate(xmed ~ type + year, data=xmed_Type_Year ,mean)

xmed_plot <- ggplot(xmed_Type_Year_agg, aes(x=year, y=xmed, fill= type, group=type)) + 
  geom_bar(position="dodge", stat = "identity") + 
  scale_fill_hp_d(option = "LunaLovegood") +
  labs(subtitle="Percentage of students exempted from vaccination for medical reasons", 
       y="Mean percent exempted", 
       x="Year", 
      # title="TidyTuesday 25.02.20202",
       caption="")

plot(xmed_plot)

xper_Type_Year<-subset(measles, year!='null' & type != 'NA', select=c(year,type,xper))
xper_Type_Year_agg <- aggregate(xper ~ type + year, data=xper_Type_Year ,mean)

xper_plot <- ggplot(xper_Type_Year_agg, aes(x=year, y=xper, fill= type)) + 
  geom_bar(position="dodge", stat = "identity") + 
  scale_fill_hp_d(option = "LunaLovegood") +
  labs(subtitle="Percentage of students exempted from vaccination for personal reasons", 
       y="Mean percent exempted", 
       x="Year", 
      # title="TidyTuesday 25.02.20202",
       caption="")

plot(xper_plot)

library(patchwork)
(mmr_plot | xmed_plot |xper_plot)
mmr_plot | (xmed_plot/ xper_plot)
