library(MASS)
library(ordinal)
library(ggplot2)
library(dplyr)
library(ggmap)
library(maps)
library(ggthemer)

setwd("C:/Users/Ishana/Documents/PhD/PhD")

#### Loading in and cleaning data ####
dat<-read.csv("Recovery.csv")
dat

dat <- dat %>% mutate_all(~ifelse(is.nan(.), NA, .))
dat$max <- as.numeric(dat$max)
dat$gdp <- as.numeric(dat$gdp)
dat$lat <- as.numeric(dat$lat)

#### Constructing candidate model set for outcome magnitude drivers ####
M1 <- glmer(success ~ (1|Study.id) + (1| species_id) + type + predator,
             family = Gamma, 
             data = dat)

M2 <- glmer(success ~ (1|Study.id) + (1| species_id) + lat + type + predator,
            family = Gamma, 
            data = dat)

M3 <- glmer(success ~ (1|Study.id) + (1| species_id) + lat + log_mass + type,
            family = Gamma, 
            data = dat)

M4 <- glmer(success ~ (1|Study.id) + (1| species_id) + absence  + type + predator,
            family = Gamma, 
            data = dat)

M5 <- glmer(success ~ (1|Study.id) + (1| species_id) + cascade + predator + type,
            family = Gamma, 
            data = dat)

ModTable <- model.sel(M1, M2, M3, M4, M5)
summary(ModTable)
ModTable$cum.weight = cumsum(ModTable$weight)
ModTable

#### Ordination Plot ####

## Preparing the data
dat <- arrange(dat, desc(success))
dat$low <- dat$success - dat$Variance
dat$high <- dat$success + dat$Variance

significant <- subset(dat, dat$low >0)
significant$alignment <- as.factor(significant$alignment)
levels(significant$alignment)
significant$alignment <-  relevel(significant$alignment, ref='aligned')
significant$alignment <- factor(significant$alignment, levels=c('unaligned', "nuetral", "aligned"))

## Creating ordinal model candidate set
ord_mix1 <- clmm(alignment ~ (1|Study.id) + (1| species_id) + consequences + category + log_gdp, 
                 data = significant)
ord_mix2 <- clmm(alignment ~ (1|Study.id) + (1| species_id) + log_gdp + predator + consequences, 
                 data = significant)
ord_mix3 <- clmm(alignment ~ (1|Study.id) + (1| species_id) + log_mass + predator + consequences, 
                 data = significant)
ord_mix4 <- clmm(alignment ~ (1|Study.id) + (1| species_id) + type + log_gdp + predator, 
                 data = significant)
ord_mix5 <- clmm(alignment ~ (1|Study.id) + (1| species_id) + type + category + predator, 
                 data = significant)
ModTable <- model.sel(ord_mix3, ord_mix4, ord_mix5, ord_mix6, ord_mix8)
summary(ModTable)
ModTable$cum.weight = cumsum(ModTable$weight)
ModTable

#### Figures Creation #####
## Figure 2
nation.x <- dat$long
nation.y <- dat$lat
predator <- dat$predator
nation.y <- as.numeric(dat$lat)
type <- dat$type
mapWorld <- borders("world", colour="#E0E0E0", fill="#E0E0E0")

ggplot() + mapWorld + 
  geom_point(aes(x=nation.x, y=nation.y, col = type, shape = predator), 
             size=4, alpha = 0.5) +theme_classic() + 
  theme(legend.title = element_text("Type of Predator Recovery"))

## Figure 3 - Descriptive Statistics
cat_x_align <- ggplot(dat, aes(x = fct_infreq(category), fill = alignment)) +geom_bar(stat = "count", col = "black") +
  theme_classic() + scale_fill_manual(values = c("#e5857b", "#7d8bae", "#45496a")) + xlab("Community Response") +
  theme(axis.text = element_text(size = 13)) + theme(axis.title = element_text(size = 13)) + ylab("Number of case studies") +
  theme(axis.text.x = element_text(angle = 35, vjust = 0.5))
cat_x_align

dat$predator <- as.character(dat$predator)
pred_x_align <- ggplot(dat, aes(x = fct_infreq(predator), fill = alignment)) +geom_bar(stat = "count", col = "black") +
  theme_classic() + scale_fill_manual(values = c("#e5857b", "#7d8bae", "#45496a")) +
  xlab("Predator Community Composition") + theme(axis.text = element_text(size = 12)) + ylab("Number of case studies") +
  theme(axis.title = element_text(size = 13))
pred_x_align

## Figure 4 - Raw data
raw_data <- ggplot(dat, aes(x = reorder(id, success), y = success, ymin = low, ymax = high, fill = type, 
                       shape = predator)) +
  geom_pointrange(size = 0.6, ) + coord_flip() +
  theme_classic() + xlab(" ") + geom_hline(yintercept= 0, color = "black", linetype="dashed",
                                           alpha = 0.5) +
  theme(axis.text.y = element_blank())+
  theme(axis.ticks.y = element_blank()) + ylab("Response Ratio") +
  theme(axis.text.x = element_text(size = 15)) +
  theme(axis.title.x =element_text(size = 18)) +
  scale_shape_manual(values = c(21, 22, 23)) +
  scale_fill_manual(values = c( "#38C7CB", "#F8776E"))


