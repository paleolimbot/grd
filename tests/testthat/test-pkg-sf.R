
test_that("sf integration works", {
  skip_if_not_installed("sf")

  grid <- grd(nx = 1, ny = 1, type = "centers")
  sf::st_crs(grid) <- sf::st_crs("OGC:CRS84")
  expect_identical(sf::st_crs(grid), sf::st_crs("OGC:CRS84"))

  expect_identical(
    sf::st_bbox(grid),
    sf::st_bbox(
      sf::st_as_sfc(rct(0.5, 0.5, 0.5, 0.5, crs = sf::st_crs("OGC:CRS84")))
    )
  )

  expect_identical(
    sf::st_as_sfc(grid),
    sf::st_sfc(sf::st_point(c(0.5, 0.5)), crs = sf::st_crs("OGC:CRS84"))
  )

  expect_identical(
    sf::st_as_sf(grid),
    sf::st_as_sf(data.frame(geometry = sf::st_as_sfc(grid)))
  )

  expect_identical(
    sf::st_geometry(grid),
    sf::st_as_sfc(grid)
  )
})
