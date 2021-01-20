#' A \code{ggsave} alias
#'
#' \code{ggsave}, but with default values.
#'
#' @param filename File name to create on disk.
#' @param plot Plot to save, defaults to last plot displayed.
#' @param device Device to use. Can either be a device function
#'   (e.g. [png()]), or one of "eps", "ps", "tex" (pictex),
#'   "pdf", "jpeg", "tiff", "png", "bmp", "svg" or "wmf" (windows only).
#' @param path Path of the directory to save plot to: `path` and `filename`
#'   are combined to create the fully qualified file name. Defaults to the
#'   working directory.
#' @param scale Multiplicative scaling factor.
#' @param width,height,units Plot size in `units` ("in", "cm", or "mm").
#'   If not supplied, uses the size of current graphics device.
#' @param dpi Plot resolution. Also accepts a string input: "retina" (320),
#'   "print" (300), or "screen" (72). Applies only to raster output types.
#' @param limitsize When `TRUE` (the default), `ggsave()` will not
#'   save images larger than 50x50 inches, to prevent the common error of
#'   specifying dimensions in pixels.
#' @param ... Other arguments passed on to the graphics device function,
#'   as specified by `device`.
#' @importFrom ggplot2 ggsave
#'
#' @export


ggsave <- function(filename, plot = ggplot2::last_plot(),
                   device = NULL, path = NULL, scale = 1,
                   width = 8.5, height = 4.75, units = "in",
                   dpi = 600, limitsize = TRUE, ...) {

    ggplot2::ggsave(filename, plot = plot, device = device, path = path,
                    scale = scale, width = width, height = height,
                    units = units, dpi = dpi, limitsize = limitsize, ...)
}
