
# regsistered in zzz.r
st_bbox.grd <- function(x, ...) {
  # workaround until st_bbox() is implemented for rct
  sf::st_bbox(st_as_sfc.grd(x))
}

st_crs.grd <- function(x, ...) {
  sf::st_crs(wk_crs(x$bbox))
}

`st_crs<-.grd` <- function(x, value) {
  wk_set_crs(x, value)
}

st_as_sfc.grd <- function(x, ...) {
  result <- wk_handle(x, sfc_writer())
  sf::st_crs(result) <- sf::st_crs(wk_crs(x))
  result
}

st_as_sf.grd <- function(x, ...) {
  sf::st_as_sf(data.frame(geometry = st_as_sfc.grd(x)))
}

st_geometry.grd <- function(x, ...) {
  st_as_sfc.grd(x)
}
