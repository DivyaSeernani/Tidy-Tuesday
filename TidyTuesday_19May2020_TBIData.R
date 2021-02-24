## Get the data - There are three files, I choose the one with age related data

tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')

### Let's look at it - what is the dataframe made of?
str(tbi_age)
summary(tbi_age)

### Do we want to fix something before we proceed to plot it?
## In this case, I would like the age to be a factor

tbi_age$age_group<-as.factor(tbi_age$age_group)

## I would also like it to be ordered as human age progresses, hopefully removing multiple enteries

tbi_age$age_group <- ordered(tbi_age$age_group, levels = c("0-4", "5-14", "15-24", "25-34", "35-44", "45-54", "55-64", "65-74", "75+"))

tbi_age<-na.omit(tbi_age)

### ggplot

library(ggplot2)
library(gameofthrones)

bar_plot<-ggplot(tbi_age, aes(x=age_group, y=number_est, fill=type)) + 
  geom_bar(position="dodge",stat="identity", width=1) + 
  scale_fill_got_d(option = "Lannister", direction = - 1)+
  labs(title="Tidy Tuesdays", 
       subtitle="Number of cases of Traumatic Brain Injury per Age-Group", 
       caption="R-Ladies Freiburg, 19.05.2020",
       y="Number of Cases of TBI", 
       x="Age Group")+
  # set transparency
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "transparent",colour = NA),
    plot.background = element_rect(fill = "transparent",colour = NA),
    axis.text.x=element_text(angle=50, size=14, colour= "black", vjust=0.5),
    axis.text.y=element_text(size=14, colour= "black"),
    plot.title = element_text(size=20, face="bold", margin = margin(10, 0, 10, 0))
  )

library(ggimage)
library(magick)
library(cowplot)

img = image_read('E:/R-Ladies/TidyTuesday/photo-1510698454686-1e2552e058e0.jpg')
image_info(img)

img2<-image_negate(img)
img3<-image_blur(img2, 6, 5)

options(scipen=999)

ggdraw() +
  draw_image(img3) +
  draw_plot(bar_plot)  

