
test_that("grd_data_generic() works for the column-major case", {
  data <- array(0:5, dim = c(2, 3, 1))

  data_g <- grd_data_generic(data, data_order = c("y", "x", NA))
  expect_identical(dim(data_g), dim(data))
  expect_identical(
    data_g[1:2, 1, ],
    grd_data_generic(data[1:2, 1, , drop = FALSE])
  )
  expect_identical(
    data_g[1:2, , ],
    grd_data_generic(data[1:2, , , drop = FALSE])
  )
  expect_identical(
    data_g[, 1, ],
    grd_data_generic(data[, 1, , drop = FALSE])
  )
})

test_that("grd_data_generic() works for the row-major case", {
  data <- array(0:5, dim = c(2, 3, 1))

  data_g <- grd_data_generic(data, data_order = c("x", "y", NA))
  expect_identical(dim(data_g), c(3L, 2L, 1L))
  expect_identical(
    data_g[1:2, 1, ]$grid_data,
    aperm(aperm(data, c(2, 1, 3))[1:2, 1, , drop = FALSE], c(2, 1, 3))
  )
  expect_identical(
    data_g[1:2, , ]$grid_data,
    aperm(aperm(data, c(2, 1, 3))[1:2, , , drop = FALSE], c(2, 1, 3))
  )
  expect_identical(
    data_g[, 1, ]$grid_data,
    aperm(aperm(data, c(2, 1, 3))[, 1, , drop = FALSE], c(2, 1, 3))
  )
})

test_that("grd_data_generic() works for the flipped case", {
  data <- array(0:5, dim = c(2, 3, 1))

  data_g <- grd_data_generic(data, data_order = c("-y", "-x", NA))
  expect_identical(dim(data_g), dim(data))
  expect_identical(data_g[1, 1, ]$grid_data, array(5L, dim = c(1, 1, 1)))
  expect_identical(data_g[2, 3, ]$grid_data, array(0L, dim = c(1, 1, 1)))
  expect_identical(data_g[3, 2, ]$grid_data, array(NA_integer_, dim = c(1, 1, 1)))
})
