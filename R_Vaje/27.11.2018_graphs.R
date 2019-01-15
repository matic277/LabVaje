install.packages("MASS")
library(MASS)

plot(UScereal$sugars, UScereal$calories, type="p")
title("UScereal")

# # # # #

library(grid)

x = UScereal$sugars
y = UScereal$calories

pushViewport(plotViewport())
pushViewport(dataViewport(x,y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x, y)
grid.text("sugar", x=unit(-3, "lines"), rot=90)
grid.text("calories", y=unit(-3, "lines"), rot=0)
popViewport(2)

# # # # #

library(lattice)
xyplot(MPG.city~Horsepower | Cylinders, data=Cars93)

# # # # #

library(ggplot2)
title = "ggplot2 plot of UScereal"
plot = ggplot(UScereal, aes(x=sugars, y=calories))
plot + geom_point(shape=as.character(UScereal$shelf), size=3) +
  annotate("text", label=title, x=3, y=400, colour="red")

# # # # #

# same output
qplot(clarity, data=diamonds, fill=cut, geom="bar")
ggplot(diamons, aes(clarity, fill=cut) + geom_bar())

# # # # #

# scatterplot
qplot(wt, mpg, data=mtcars)

# transform input data with functions
qplot(log(wt), mpg-10, data=mtcars)

# add aesthetic mapping
qplot(wt, mpg, data=mtcars, color=qsec)

# change size of points
qplot(wt, mpg, data=mtcars, color=qsec, size=3)
qplot(wt, mpg, data=mtcars, color=qsec, size=I(3))

# continous scale vs discrete scale
qplot(wt, mpg, data=mtcars, color=cyl)
qplot(wt, mpg, data=mtcars, color=factor(cyl))

# different aesthetic mappings
qplot(wt, mpg, data=mtcars, shape=factor(cyl))
qplot(wt, mpg, data=mtcars, size=qsec)

# combine mappings
qplot(wt, mpg, data=mtcars, size=qsec, color=factor(cyl))
qplot(wt, mpg, data=mtcars, size=qsec, color=cyl)

# # # # #

# barplot
qplot(factor(cyl), data=mtcars, geom="bar")

# flip plot by 90degrees
qplot(factor(cyl), data=mtcars, geom="bar") + coord_flip()

# difference between fill/color bars
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(cyl))
qplot(factor(cyl), data=mtcars, geom="bar", color=factor(cyl))

# fill by variable
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))

# different display of bars (stacked, dodged, identity)
qplot(clarity, data=diamonds, geom="bar", fill=cut)
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="dodge")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="fill")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="identity")

diamonds

# ggplot histogram
qplot(carat, data=diamonds, geom="histogram")

# changing binwidth (sirina stolpcev)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)

# use geom to combine plots
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))
qplot(wt, mpg, data=mtcars, color=factor(cyl), geom=c("point", "smooth"))

# tweeking the smooth plot ("loess"-method: polynomial surface using local fitting)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))

# removing standard error
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), se=FALSE)

# making line more or less wiggly (span: 0-1)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=0.6)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=1)

# using linear modelling
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm")

# using a custom formula for fitting
library(splines)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm", formula=y~ns(x,5))

# illustrate flip versus changing of variable allocation
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth"))
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth")) + coord_flip()
qplot(wt, mpg, data=mtcars, facets=cyl~., geom=c("point", "smooth"))

# # # # #

# create basic plot (hint: can not be displayed, no layers yet)
p.tmp = ggplot(mtcars, aes(mpg, wt, colour=factor(cyl)))
p.tmp

# using additional layers (hint: ggplot draws in layers)
p.tmp + layer(geom="point")
p.tmp + layer(geom="point") + layer(geom="line")
p.tmp

summary(p.tmp)

# saving plot
save(p.tmp, file="temp.rData")

# adding additional layer
p.tmp + geom_point()
p.tmp + geom_point() + geom_point(aes(y=disp))

p.tmp + geom_point(color="darkblue")

# overplotting
t.df = data.frame(x=rnorm(2000), y=rnorm(2000))
p.norm = ggplot(t.df, aes(x,y))
p.norm + geom_point()
p.norm + geom_point(shape=1)
p.norm + geom_point(shape=".")
p.norm + geom_point(colour=alpha("black", 1/2))
p.norm + geom_point(colour=alpha("blue", 1/10))

# using facets (hint: bug in margins -> doesn't work)
qplot(mpg, wt, data=mtcars, facets=.~cyl, geom="point")
qplot(mpg, wt, data=mtcars, facets=gear~cyl, geom="point")

# facet_wrap / facet_grid
qplot(mpg, wt, data=mtcars, facets=~cyl, geom="point")
p.tmp = ggplot(mtcars, aes(mpg, wt)) + geom_point()
p.tmp + facet_wrap(~cyl)
p.tmp + facet_wrap(~cyl, ncol=3)
p.tmp + facet_grid(gear~cyl)
p.tmp + facet_wrap(~cyl+gear)

# controlling scales in facets (default: scales="fixed")
p.tmp + facet_wrap(~cyl, scales="free")
p.tmp + facet_wrap(~cyl, scales="free_x")
p.tmp + facet_wrap(~cyl, scales="fixed")

# contstraint on facet_grid (all rows,columns same scale)
p.tmp + facet_grid(gear~cyl, scales="free_x")
p.tmp + facet_grid(gear~cyl, scales="free", space="free")

# using scales (color palettes, manual colors, matching of colors to values)
p.tmp = qplot(cut, data=diamonds, geom="bar", fill=cut)
p.tmp
p.tmp + scale_fill_brewer()
p.tmp + scale_fill_brewer(palette="Paired")
RColorBrewer::display.brewer.all()
p.tmp + scale_fill_manual(values=c("#7fc6bc","#083642","#b1df01","#cdef9c","#466b5d"))
p.tmp + scale_fill_manual("Color-Matching", c("Fair"="#78ac07", "Good"="#5b99d4",
                                              "Ideal"="#ff9900", "Very Good"="#5d6778", "Premium"="#da0027", "Not used"="#452354"))
# changing text (directly in qplot / additional shortcut)
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point", xlab="Descr. of x-axis", ylab="Descr. of y-axis", main="Our
Sample Plot")
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + xlab("x-axis")


