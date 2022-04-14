#**********************************************************
# Project: Application figure
# Purpose: Create a figure for my supervisor's grant application
# code: Anton Olsson-Collentine
#**********************************************************

list.files()
erp <- read.csv("Data 1990-2013 with tau values.csv")
anton_smd <- read.csv("anton_smd.csv")
anton_r <- read.csv("anton_r.csv")

anton_smd$tau <- sqrt(anton_smd$tau2)


nrow(erp[erp$Type.of.ES == "mean WLS ES", ])
nrow(erp[erp$Type.of.ES == "Weighted mean", ])
nrow(erp[erp$Type.of.ES == "Unweighted mean", ])
nrow(erp[erp$Type.of.ES == "Standardized mean gains", ])
# total 18 rows, as should be.

erp_smd <- erp[grepl("Cohen|Hedges", erp$Type.of.ES), ]
erp_r <- erp[grepl("Pearson", erp$Type.of.ES),]


### Base version
library("Hmisc")

par(mar=c(2.5,2.5,1,1))
layout(matrix(c(1,1,2,3,4,4,5,6),ncol=2, byrow = TRUE),heights=c(1,3,1,3))
# layout.show(n = 3)
plot.new()
text(0.5, 0.5, "Standardized Mean Differences", cex = 2, font = 2)
plot(x)
hist(x)

plot.new()
text(0.5,0.5,"Pearson's r",cex=2,font=2)
boxplot(x)
barplot(x)

dev.off()

## Doing it for real
svg(
    filename = "heterogeneity.svg",
    width = 7,
    height = 7,
    pointsize = 12
)

par(mar=c(4,4,1,1)) #plot margins for the 4 sides
layout(matrix(c(1, 1, 2, 3, 4, 4, 5, 6), #trick to get titles
    ncol = 2, byrow = TRUE),
    heights = c(1, 3, 1, 3))

plot.new()
text(0.5, 0.5, "Standardized Mean Differences", cex = 2, font = 2)
# van erp SMD
hist(erp_smd$tau,
    xlab = expression(bold("Between-Study Heterogeneity" ~ tau)),
    ylab = "Number of Estimates",
    main = NULL, #title
    cex.lab=1.5, cex.axis=1.5, #label sizes
    las = 1, #change orientation of y-axis labels
    font.lab = 2, #bold labels, doesn't work on text inside expression()
)
mtext(side=3, line=1, at=-0.07, adj=0, cex=1.5, "A") #print text on plot
rug(erp_smd$tau)
Hmisc::minor.tick(nx = 2, ny = 1, tick.ratio = 1)

#Anton smd
hist(anton_smd$tau,
    xlab = expression(bold("Between-Study Heterogeneity" ~ tau)),
    ylab = "Number of Estimates",
    main = NULL,
    cex.lab=1.5, cex.axis=1.5,
    las = 1,
    font.lab = 2,
    ylim = c(0, 30),
    xlim = c(0, 1)
)
mtext(side=3, line=1, at=-0.07, adj=0, cex=1.5, "B")
rug(anton_smd$tau)
minor.tick(nx = 2, ny = 1, tick.ratio = 1)

plot.new()
text(0.5,0.5,"Pearson's r",cex=2,font=2)
# van erp r
hist(erp_r$tau,
    xlab = expression(bold("Between-Study Heterogeneity" ~ tau)),
    ylab = "Number of Estimates",
    main = NULL,
    cex.lab = 1.5, cex.axis = 1.5,
    las = 1,
    font.lab = 2,
    ylim = c(0, 140),
    xlim = c(0, 0.6)
)
mtext(side=3, line=1, at=-0.04, adj=0, cex=1.5, "C")
rug(erp_r$tau)
minor.tick(nx = 2, ny = 1, tick.ratio = 1)

# Anton r
hist(anton_r$tau,
    xlab = expression(bold("Between-Study Heterogeneity" ~ tau)),
    ylab = "Number of Estimates",
    main = NULL,
    cex.lab = 1.5, cex.axis = 1.5,
    font.lab = 2,
    las = 1,
    ylim = c(0, 20),
    xlim = c(0, 0.6)
)
mtext(side=3, line=1, at=-0.04, adj=0, cex=1.5, "D")
rug(anton_r$tau)


dev.off()
