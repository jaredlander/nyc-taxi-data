eastmost <- -1*(73 + 42/60)
westmost <- -1*(74 + 15/60)
northmost <- 40 + 55/60
southmost <- 40 + 30/60

numPoints <- 100000

set.seed(42)
longs <- runif(numPoints, min=westmost, max=eastmost)
lats <- runif(numPoints, min=southmost, max=northmost)
cabs <- sample(5000, size=numPoints, replace=TRUE)

cab_info <- tibble::tibble(
    PointID=1:numPoints
    , CabID=sample(cabs)
    , Longitude=sample(longs, replace=TRUE)
    , Latitude=sample(lats, replace=TRUE)
)

readr::write_csv(cab_info, 'data/fake_cab_info.csv')
