
test_that("ij_expand_one works", {
  expect_identical(ij_expand_one(NULL, 0L), integer())
  expect_identical(ij_expand_one(NULL, 2L), 1:2)
  expect_identical(ij_expand_one(4:8, 10L), 4:8)
  expect_identical(ij_expand_one(c(start = NA, stop = NA, step = NA), 10L), 1:10)
  expect_identical(ij_expand_one(c(start = 0L, stop = 4L, step = NA), 10L), 1:4)
  expect_identical(ij_expand_one(c(start = 0L, stop = 4L, step = 2L), 10L), c(1L, 3L))

  expect_identical(ij_expand_one(0:2, 1L, out_of_bounds = "keep"), 0:2)
  expect_identical(ij_expand_one(0:2, 1L, out_of_bounds = "censor"), c(NA, 1L, NA))
  expect_identical(ij_expand_one(0:2, 1L, out_of_bounds = "discard"), 1L)
  expect_identical(ij_expand_one(0:2, 1L, out_of_bounds = "squish"), c(1L, 1L, 1L))
  expect_error(ij_expand_one(0:2, 1L, out_of_bounds = "not an option"), "must be one of")

  expect_identical(ij_expand_one(c(start = 0, stop = 0, step = 1L), 1L), integer())
  expect_error(ij_expand_one(TRUE, 1L), "must be NULL, numeric")
})

test_that("ij_handle_out_of_bounds2 works", {
  # no oob
  expect_identical(
    ij_handle_out_of_bounds2(list(i = 1:3, j = 4:6), n = c(3, 6), out_of_bounds = "keep"),
    list(i = 1:3, j = 4:6)
  )

  ij <- list(i = 0:2, j = 4:6)
  expect_identical(
    ij_handle_out_of_bounds2(ij, n = c(2L, 5L), out_of_bounds = "keep"),
    ij
  )
  expect_identical(
    ij_handle_out_of_bounds2(ij, n = c(2L, 5L), out_of_bounds = "censor"),
    list(i = c(NA, 1L, NA), j = c(NA, 5L, NA))
  )
  expect_identical(
    ij_handle_out_of_bounds2(ij, n = c(2L, 5L), out_of_bounds = "discard"),
    list(i = 1L, j = 5L)
  )
  expect_identical(
    ij_handle_out_of_bounds2(ij, n = c(2L, 5L), out_of_bounds = "squish"),
    list(i = c(1L, 1L, 2L), j = c(4L, 5L, 5L))
  )

  expect_error(
    ij_handle_out_of_bounds2(ij, c(2L, 5L), out_of_bounds = "not an option"),
    "must be one of"
  )
})

test_that("ij_to_slice_one works", {
  expect_identical(ij_to_slice_one(NULL, 0L), integer())
  expect_identical(ij_to_slice_one(NULL, 2L), c(start = 0L, stop = 2L, step = 1L))
  expect_identical(ij_to_slice_one(integer(), 2L), integer())
  expect_identical(ij_to_slice_one(1L, 2L), c(start = 0L, stop = 1L, step = 1L))
  expect_identical(ij_to_slice_one(4:8, 10L), c(start = 3L, stop = 8L, step = 1L))
  expect_identical(
    ij_to_slice_one(seq(1L, 9L, by = 2L), 10L),
    c(start = 0L, stop = 9L, step = 2L)
  )
  expect_identical(
    ij_to_slice_one(c(start = NA, stop = NA, step = NA), 10L),
    c(start = 0L, stop = 10L, step = 1L)
  )
  expect_identical(
    ij_to_slice_one(c(start = 1L, stop = 2L, step = 3L), 10L),
    c(start = 1L, stop = 2L, step = 3L)
  )

  expect_error(
    ij_to_slice_one(c(1, 2, 4), 1L),
    "must be equally spaced"
  )

  expect_error(
    ij_to_slice_one(c(1, 0, -1), 1L),
    "must be equally spaced and ascending"
  )

  expect_error(
    ij_to_slice_one(NA_integer_, 1L),
    "must be finite"
  )

  expect_error(
    ij_to_slice_one(logical(), 1L),
    "must be NULL, numeric, or"
  )
})
