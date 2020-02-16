
## Trying out different colour schemes

phd_field <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-19/phd_by_field.csv")

str(phd_field)
phd_field$broad_field<-as.factor(phd_field$broad_field)
phd_field <- phd_field[ which(phd_field$year<2012), ]
phd_field$year<-as.factor(phd_field$year)


library(ggplot2)

PhDs <- ggplot(phd_field, aes(x=broad_field)) + 
  geom_bar(aes(col=year)) + 
  labs(subtitle="Number of PhDs per field", 
       y="Number of PhDs", 
       x="Broad Field", 
       title="Scatterplot")

plot(PhDs)


library("wesanderson")

PhDs_wesanderson <- ggplot(phd_field, aes(x=broad_field, fill= year, group=year)) + 
  geom_bar() + 
  scale_fill_manual(values = wes_palette("Rushmore1"))+
  labs(subtitle="Number of PhDs per field", 
       y="Number of PhDs", 
       x="Broad Field", 
       title="Wes Anderson - Rushmore",
       caption="https://github.com/karthik/wesanderson")

plot(PhDs_wesanderson)


library(gameofthrones)

PhDs_GoT <- ggplot(phd_field, aes(x=broad_field, fill= year, group=year)) + 
  geom_bar() + 
  scale_fill_got_d(option = "Daenerys", direction = - 1)+
  labs(subtitle="Number of PhDs per field", 
       y="Number of PhDs", 
       x="Broad Field", 
       title="GoT - Daenerys",
       caption="https://github.com/aljrico/gameofthrones")

plot(PhDs_GoT)


library(harrypotter)

PhDs_HP <- ggplot(phd_field, aes(x=broad_field, fill= year, group=year)) + 
  geom_bar() + 
  scale_colour_hp_d(option = "LunaLovegood") +
  labs(subtitle="Number of PhDs per field", 
       y="Number of PhDs", 
       x="Broad Field", 
       title="HP - LunaLovegood",
       caption="https://github.com/aljrico/gameofthrones")

plot(PhDs_HP)

